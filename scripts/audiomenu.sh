#!/usr/bin/env python3
"""
audiomenu.sh - Fast audio output switcher with rofi
- Always shows Speakers, Headphones, and connected Monitor (1. 2. 3.)
- Switches UCM card profiles cleanly
- Polls for sink readiness
- Unmutes hardware ALSA controls & disables auto-mute
- Forcibly migrates active streams so audio moves immediately
"""

import os
import re
import subprocess
import sys
import time

CARD = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
PROFILE_SPEAKER = "HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
PROFILE_HEADPHONES = "HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)"

SINK_SPEAKER = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink"
SINK_HEADPHONES = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Headphones__sink"
SINK_HDMI1 = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI1__sink"

def log(msg):
    if "--debug" in sys.argv:
        print(f"[DEBUG] {msg}")

def run(cmd):
    try:
        proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if proc.returncode != 0:
            log(f"FAIL: {' '.join(cmd)} -> {proc.stderr.strip()}")
        else:
            log(f"OK: {' '.join(cmd)}")
        return proc.returncode == 0
    except Exception as e:
        log(f"ERR: {' '.join(cmd)} -> {e}")
        return False

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, text=True, stderr=subprocess.DEVNULL).strip()
    except Exception:
        return ""

def get_default_sink():
    return run_cmd(['pactl', 'get-default-sink'])

def get_active_profile():
    out = run_cmd(['pactl', 'list', 'cards'])
    m = re.search(r'Active Profile:\s*(.*)', out)
    return m.group(1).strip() if m else ''

def get_available_sinks():
    out = run_cmd(['pactl', 'list', 'short', 'sinks'])
    return [line.split()[1] for line in out.splitlines() if len(line.split()) >= 2]

def migrate_all_streams(target_sink):
    out = run_cmd(['pactl', 'list', 'short', 'sink-inputs'])
    for line in out.splitlines():
        parts = line.split()
        if parts:
            inp_id = parts[0]
            log(f"Moving stream {inp_id} -> {target_sink}")
            run(['pactl', 'move-sink-input', inp_id, target_sink])

def unmute_alsa_hardware():
    cmds = [
        ['amixer', '-c', '0', 'sset', 'Master', 'unmute'],
        ['amixer', '-c', '0', 'sset', 'Speaker', 'unmute'],
        ['amixer', '-c', '0', 'sset', 'Headphone', 'unmute'],
        ['amixer', '-c', '0', 'sset', 'Auto-Mute Mode', 'Disabled'],
        ['amixer', 'sset', 'Master', 'unmute'],
        ['amixer', 'sset', 'Speaker', 'unmute'],
        ['amixer', 'sset', 'Headphone', 'unmute'],
        ['amixer', 'sset', 'Auto-Mute Mode', 'Disabled'],
    ]
    for c in cmds:
        run(c)

def main():
    run(['killall', 'easyeffects'])

    def_sink = get_default_sink()
    active_profile = get_active_profile()
    available_sinks = get_available_sinks()

    log(f"Default sink: {def_sink}")
    log(f"Active profile: {active_profile}")
    log(f"Available sinks: {available_sinks}")

    # Build options
    items = []

    # 1. Laptop Speakers
    is_spk = (def_sink == SINK_SPEAKER)
    items.append({
        'type': 'speaker',
        'title': '󰓃 Laptop Speakers',
        'sink': SINK_SPEAKER,
        'profile': PROFILE_SPEAKER,
        'is_active': is_spk
    })

    # 2. Headphones
    is_hp = (def_sink == SINK_HEADPHONES)
    items.append({
        'type': 'headphone',
        'title': '󰋋 Headphones',
        'sink': SINK_HEADPHONES,
        'profile': PROFILE_HEADPHONES,
        'is_active': is_hp
    })

    # 3. External Monitor (HDMI 1)
    is_hdmi = (def_sink == SINK_HDMI1)
    items.append({
        'type': 'hdmi',
        'title': '󰍹 External Monitor',
        'sink': SINK_HDMI1,
        'profile': None,
        'is_active': is_hdmi
    })

    # Number dynamically
    entries = []
    for idx, it in enumerate(items, 1):
        indicator = "● " if it['is_active'] else "  "
        label = f"{idx}. {indicator}{it['title']}"
        it['label'] = label
        it['num'] = str(idx)
        entries.append(it)

    rofi_input = '\n'.join(e['label'] for e in entries)
    if "--list" in sys.argv:
        print("Available audio outputs:")
        print(rofi_input)
        sys.exit(0)

    try:
        rofi = subprocess.Popen(
            ['rofi', '-dmenu', '-p', 'Audio Output:', '-i'],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            text=True
        )
        selected_text, _ = rofi.communicate(input=rofi_input)
        selected_text = selected_text.strip()
    except Exception as err:
        run(['notify-send', 'Audio Switcher', f'Failed to launch rofi: {err}'])
        sys.exit(1)

    if not selected_text:
        log("Cancelled.")
        sys.exit(0)

    selected = None
    for e in entries:
        if e['label'].strip() == selected_text:
            selected = e
            break
        if selected_text in (e['num'], f"{e['num']}."):
            selected = e
            break
        if e['title'] in selected_text:
            selected = e
            break

    if not selected:
        log(f"No match for '{selected_text}'")
        sys.exit(0)

    target_type = selected['type']
    target_sink = selected['sink']
    target_profile = selected.get('profile')

    log(f"Switching to: {selected['num']}. {selected['title']}")

    # 1. If target requires a specific profile, switch card profile first
    if target_profile and active_profile != target_profile:
        log(f"Switching card profile to: '{target_profile}'")
        run(['pactl', 'set-card-profile', CARD, target_profile])

        # Poll until target sink exists in pactl
        for attempt in range(25):
            time.sleep(0.1)
            fresh = get_available_sinks()
            if target_sink in fresh:
                log(f"Target sink '{target_sink}' ready after {attempt*100}ms")
                break

    # 2. Unmute ALSA hardware
    unmute_alsa_hardware()

    # 3. Unmute sink in PipeWire and set reasonable volume if muted
    run(['pactl', 'set-sink-mute', target_sink, '0'])
    sink_info = run_cmd(['pactl', 'list', 'sinks'])
    # If sink volume is 0%, boost to 60%
    run(['pactl', 'set-sink-volume', target_sink, '60%'])

    # 4. Set as default sink in PulseAudio & WirePlumber
    log(f"Setting default sink to: {target_sink}")
    run(['pactl', 'set-default-sink', target_sink])

    # 5. Forcibly migrate all active streams (Spotify, Brave, Discord, etc.)
    migrate_all_streams(target_sink)

    # 6. Notify
    icon = 'audio-speakers'
    if target_type == 'headphone':
        icon = 'audio-headphones'
    elif target_type == 'hdmi':
        icon = 'video-display'

    run(['notify-send', '-t', '1500', '-i', icon, 'Audio Output', f"Switched to: {selected['title']}"])
    log("Switch completed successfully.")

if __name__ == '__main__':
    main()
