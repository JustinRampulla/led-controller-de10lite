# LED Controller Peripheral — DE10-Lite

An FPGA-based **LED Controller Peripheral** developed for the **DE10-Lite** board using **VHDL**. This project implements a 10-level **PWM-based brightness control** system for LEDs, integrates seamlessly with the **SCOMP I/O framework**, and provides a user-friendly API for controlling both LED patterns and brightness levels.

Developed as part of **ECE 2031 Peripheral Project** at **Georgia Institute of Technology**.

---

## 🎯 Overview

The goal of this project was to design a custom **SCOMP peripheral** to control the brightness and patterns of LEDs connected to the DE10-Lite board. The system uses **Pulse Width Modulation (PWM)** with a **gamma correction plan** (γ = 2.2) for perceptual brightness accuracy. The peripheral was mapped to the **SCOMP I/O address 0x001** for compatibility and simplicity.

---

## ✨ Features

### **Core Functionality**
- Controls **10 LEDs** on the DE10-Lite board
- Supports **10 levels of brightness** (0% to 100%) using PWM
- Adjustable LED patterns through a **4-bit control interface**
- Integrated with **SCOMP I/O decoder** at address **0x001**
- Clean and reusable **VHDL design**

### **Planned Features (Future Improvements)**
- **Gamma correction (γ = 2.2)** for perceptual accuracy
- **PWM logic refinement** for smoother dimming
- **Read-back support** to verify LED states

---

## 🛠️ Hardware Requirements

| Component          | Purpose                          |
|--------------------|----------------------------------|
| **DE10-Lite FPGA** | Implements the LED peripheral   |
| **SCOMP CPU**      | Interfaces with I/O decoder     |
| **LEDs**           | Visual output for brightness levels |

---

## 📁 Project Structure

```
led-controller-de10lite/
│── src/
│   ├── led_controller.vhd      # Main peripheral logic
│   ├── pwm_generator.vhd       # PWM engine for brightness control
│   ├── io_decoder.vhd          # Integrates peripheral into SCOMP I/O
│   ├── top_level.vhd           # System-level integration
│
│── sim/
│   ├── led_controller_tb.vhd   # Testbench for LED controller
│   └── waveform.sav            # Simulation results
│
│── docs/
│   └── design_notes.md         # Design decisions & implementation notes
│
│── README.md
│── .gitignore
│── LICENSE
```

---

## 🚀 How It Works

1. **Brightness Control:** Uses bits **[13:10]** from the I/O data for brightness levels (0–9).
2. **LED Patterns:** Uses bits **[9:0]** to control individual LED states.
3. **PWM Engine:** Generates duty cycles based on brightness value.
4. **SCOMP Integration:** Peripheral is mapped at **I/O address 0x001** for compatibility.

---

## 🧩 Skills Demonstrated

- **VHDL & Digital Design** — Peripheral creation & PWM implementation
- **FPGA Development** — Quartus Prime & DE10-Lite programming
- **Embedded Systems** — I/O integration with SCOMP framework
- **API Design** — User-friendly interface for hardware control
- **Debugging & Simulation** — ModelSim, SignalTap, and testbench development

---

## 📜 License

This project is licensed under the [MIT License](./LICENSE).

---

## 👤 Author

**Justin M. Rampulla**  
📧 Email: [justinrampulla1@gmail.com](mailto:justinrampulla1@gmail.com)  
🔗 LinkedIn: [linkedin.com/in/justinrampulla](https://www.linkedin.com/in/justinrampulla)
