# simple SoC

#### address

|   addr     | module          |
|        ---:|:---             |
| **`00_xxxxxx`** | Programm        |
| **`01_xxxxxx`** | Registers, IO   |
| | |
| `..0xxxx`  | User Registers  |
| `..10000`  | flag register   |
| `..10001`  | timer interapt mask   |
| `..11001`  | digits on board |
| `..11100`  | GPU command     |
| `..11101`  | GPU data        |
| **`10_xxxxxx`** | RAM             |
| **`11_xxxxxx`** | Stack           |
