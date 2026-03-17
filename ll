* TTL to RS232 to 3.3V Conversion

* Input Signal (0 to 5V pulse)
Vin in 0 PULSE(0 5 0 1n 1n 5m 10m)

* 7404 Inverter (behavioral model)
Binv inv_out 0 V = 5 - V(in)

* Comparator (Level Shifter to ±10V)
Vcc Vp 0 12
Vee Vn 0 -12

* Ideal Op-Amp Model
Ecomp out_rs232 0 inv_out 2 1e6
Rref 2 0 2.5k
Vref 2 0 DC 2.5

* Output limiting (simulate saturation)
D1 out_rs232 Vp Dclamp
D2 Vn out_rs232 Dclamp
.model Dclamp D

* Voltage Divider to 3.3V
R1 out_rs232 out_final 20k
R2 out_final 0 10k

.tran 0 50m
.control
run
plot V(in) V(inv_out) V(out_rs232) V(out_final)
.endc
.end



Step 4: Fix Wiring (Important for this file)

Because LTspice is graphical, you may need to connect wires manually:

🔧 Use:

Press F3 (Wire tool)

Connect these:

Input

Vin → gates of PMOS & NMOS

MOSFET inverter

PMOS source → 5V

NMOS source → GND

Drains tied → inv_out

Op-amp

inv_out → + input

Vref (2.5V) → - input

Supply:

V+ → +12V

V- → -12V

Output divider

Op-amp output → R1 → final_out

final_out → R2 → GND

🟢 Step 5: Run Simulation

Click Run button (running man icon)

🟢 Step 6: View Waveforms

Click on nodes to probe:

Click input wire → Vin

Click inverter output → inv_out

Click op-amp output → rs232_out

Click final node → final_out

📊 What You Should See
Signal	Output
Vin	0 → 5V
inv_out	5 → 0V
rs232_out	+10V ↔ -10V
final_out	+3.3V ↔ -3.3V
⚠️ Common Issues (Quick Fix)
Problem	Fix
Flat line	Check ground connection
No ±10V	Check op-amp supply
No inversion	MOSFET wiring wrong
Simulation error	Ensure .tran 50m exists
🧠 Pro Tip

If wiring feels messy:

👉 Press Ctrl + Right Click → Drag components to rearrange neatly
