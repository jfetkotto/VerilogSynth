# FPGA synthesizer based on Direct Digital Synthesis
Synthesizer core written in Verilog.

Full project utilises a NodeMCU ESP module to take OSC input over WiFi and communicate with the synth core.

## Implementation
FPGA exposes 2 Oscillators and outputs unsigned on 16 data lines.
Control of the osillators is via SPI MODE 0 interface. Send 1 control byte, followed by data, follwed by an arbitrary byte.

### OSC 1

| Control Byte |   Command    |   Data Size  |
| ------------ | ------------ | ------------ |
|     0x01     |  Wave Type   |    1 Byte    |
|     0x02     |    Phase     |    2 Bytes   |
|     0x03     |  Amplitude   |    2 Bytes   |
|     0x04     |  Frequency   |    3 Bytes   |

### OSC 2

| Control Byte |   Command    |   Data Size  |
| ------------ | ------------ | ------------ |
|     0x11     |  Wave Type   |    1 Byte    |
|     0x12     |    Phase     |    2 Bytes   |
|     0x13     |  Amplitude   |    2 Bytes   |
|     0x14     |  Frequency   |    3 Bytes   |


### Wavetype
|  Byte Value  |  Wave Type   |
| ------------ | ------------ |
|     0x00     |    Noise     |
|     0x01     |   Triangle   |
|     0x02     |     Saw      |
|     0x03     |    Square    |
|     0x04     |     Sine     |

### Controlling the synth

For Example, to set *OSC 1* to Full Volume, the following strategy should be used

```c
send_SPI(0x03); // Control Code
send_SPI(0xff); // LSB of data
send_SPI(0xff); // MSB of data
send_SPI(0x00); // Kick state machine with footer data
```

To adjust *OSC 2* to Half the maximum frequency
```c
send_SPI(0x14); // Control Code
send_SPI(0xff); // LSB of data
send_SPI(0xff);
send_SPI(0x7f); // MSB of data
send_SPI(0x00); // Kick state machine
```

