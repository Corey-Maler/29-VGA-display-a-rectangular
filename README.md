# simple SoC

### address

|   addr     | module          | MNEMONIC | comment |
|        ---:|:---             | :--- | :--- |
| **`00_xxxxxx`** | Programm        | | |
| `..0xxxx` | interrupts | | |
| `..00000` | *reset* | | |
| `..00001` | *timer_1* | | controlled by $rt |
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

### flag register
`
[0] -- carry
[1] -- does result of last operation is zero
`
### Adressing:
#### Direct:
`$r0 - $r15` registers
`xxxx` RAM or direct address

#### indirect
`@r0 - @r15` registers
`@xxxx`

#### relative
`+xxxx` // don't know

#### constant
* `b1100_1111` // binary
* `o1223_3212` // octal
* `d10` // deceminal
* `h12` // hex

### Commands
4 word (16 bytes).
` | OP_CODE | O_ADDR | [I_ADDR_1] | [I_ADDR_2] | `

```
PUSH [a];
POP [a];
JMP [a];
MOV [a], [b]; // a = b
ADD [a], [b], [c]; // a = b + c]

JPMI [a]; // jump if C
JMPZ [a]; // jump if result of last operation -- zero
```
