# simple SoC

### address

|   addr     | module          | MNEMONIC | comment |
|        ---:|:---             | :--- | :--- |
| **`00_xxxxxx`** | Programm        | | |
| `..0xxxx` | interrupts | | |
| `..00000` | *reset* | | |
| `..00001` | *timer1 | | controlled by $rt |
| **`01_xxxxxx`** | Registers, IO   | | |
| `..0xxxx`  | User Registers  | $r0-$r15 | | 
| `..10000`  | flag register   | $rf | |
| `..10001`  | timer interapt mask   | $rt | |
| `..10010`  | stack head | $st | |
| `..11001`  | digits on board | | |
| `..11100`  | GPU command     | | |
| `..11101`  | GPU data        | | |
| **`10_xxxxxx`** | RAM             | | |
| **`11_xxxxxx`** | Stack           | | |

### Adressing:
#### Direct:
`$r0 - $r15` registers
`xxxx` RAM or direct address

#### indirect
`@r0 - @r15` registers
`@xxxx`

#### relative
`+xxxx` // don't know


### Commands
4 word (16 bytes).
` | OP_CODE | O_ADDR | [I_ADDR_1] | [I_ADDR_2] | `

```
PUSH [a];
POP [a];
```
