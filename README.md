# whoopsie-protocol

Part of [project-whoopsie](https://github.com/project-whoopsie) — see the [main repository](https://github.com/project-whoopsie/whoopsie) for context on what this project is and why it exists.

- [whoopsie-backend](https://github.com/project-whoopsie/whoopsie-backend) ← The FastAPI metrics server.
- [whoopsie](https://github.com/project-whoopsie/whoopsie) ← The Flutter companion app.

---

## What is this?

The part that actually matters.

The app and the backend are implementations. This is the research that makes them possible — the documented BLE protocol that WHOOP 4.0 speaks, reverse engineered by watching what my own device said over the air.

It lives in its own repository because the documentation is useful to anyone building anything on top of this — regardless of language, platform, or stack. You don't need Flutter. You don't need Python. You just need to know how to talk to the device.

No servers were hacked. No networks were breached. No terms of service of any third-party were violated in a way that affected anyone but myself. A device I own communicated wirelessly — I listened.

---

## Ideology

> *"You can buy a book, but the publisher still controls whether you can read it aloud."*

> *"Ownership used to mean you could open the hood. Now it means you agreed to a license."*

> *"They sold me a heart rate monitor and called it a health platform. I just want my own heartbeat data."*

> *"The most radical act left in consumer technology is understanding what your own device is doing."*

> *"If I cannot study, modify, or understand a device that is physically attached to my body — in what sense do I own it?"*

Modern wearables operate under an uncomfortable paradox: you pay for the hardware, you generate the data, you wear the risk — but the company controls the protocol, the insights, and increasingly, the device's continued function. This research is a small protest against that arrangement.

---

## Contents

`WHOOP_BLE_PROTOCOL.md` is the full protocol reference. Frame format, CRC specification, all five initialization packets, packet type constants, data record layouts for HR, IMU, and optical — everything needed to speak the protocol from scratch.

`whoop.py` is a Python script that connects to a WHOOP device over BLE and prints decoded packets to the terminal in real time. It was the primary tool used during research to validate that the documentation was correct. Runs on macOS.

---

## How the research was done

1. Enabled HCI snoop logging in Android developer options (`Developer Options → Enable Bluetooth HCI snoop log`)
2. Paired the phone with a personally-owned WHOOP 4.0 and used it normally
3. Pulled the `btsnoop_hci.log` file from the device and loaded it in Wireshark
4. Observed the BLE GATT traffic — characteristic UUIDs, notification payloads, write commands
5. Wrote scripts to reproduce what the official app was doing and verified against the live device

No proprietary software was analyzed. Everything documented here was derived from observing wireless communications broadcast by a device I own, over a radio frequency, in my own home.

---

## Tested On

- **WHOOP 4.0** (hardware codename: Harvard)

Other generations (Maverick, Goose, Puffin) may partially match the protocol documented here — the spec notes where things may diverge — but nothing has been tested against them.

---

## Running the Python script

Requires macOS (uses CoreBluetooth via pyobjc):

```bash
pip install pyobjc-framework-CoreBluetooth
python whoop.py
```

It will scan for nearby devices, connect, run the init sequence, and print decoded packets to the terminal.

---

## Legal & Ethics

This research was conducted on a device I personally own, using passive Bluetooth observation and analysis of publicly observable wireless communications.

No WHOOP systems, servers, or accounts were accessed, modified, or interfered with. No user data other than my own was captured. No circumvention of encryption was performed — the BLE protocol analyzed here uses no encryption.

Shared for **educational and research purposes only**, consistent with the spirit of security research, right-to-repair advocacy, and personal device autonomy.

**If WHOOP, Inc. believes any part of this repository violates their intellectual property rights, please contact me directly:**

📧 **abdulsaheel81@gmail.com**

I will review any request in good faith and respond promptly. I have no interest in harming WHOOP's business — I just want to understand my own heartbeat.

If you are using this to understand your own device — that is exactly the point. If you are attempting to access or interfere with someone else's device or data — don't.

---

## Contributing

This project is under-resourced and over-ambitious. If you:
- Know more about the BLE protocol than what is documented here
- Have a different generation and want to test/contribute findings
- Have figured out what the undocumented fields mean

...then open an issue or send a PR. Everything here is a starting point.

---

## Disclaimer

Provided as-is, with no warranty of any kind. Use it on your own device at your own risk.
