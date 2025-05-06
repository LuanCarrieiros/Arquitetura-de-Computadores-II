# Designs VHDL

Este repositório contém **módulos VHDL** utilizados em atividades realizadas em sala de aula. Os arquivos implementam componentes fundamentais de projetos digitais, como somadores, multiplicadores, decodificadores e uma ULA de 32 bits.

## 📁 Conteúdo dos Arquivos

| Arquivo              | Descrição                                                                 |
|----------------------|---------------------------------------------------------------------------|
| `ULA.vhd`            | Implementação de uma ULA básica com operações lógicas e aritméticas.     |
| `ULA32bits.vhd`      | Versão estendida da ULA para operar com 32 bits.                         |
| `ULA32decod.vhd`     | Decodificador de instruções para controle das operações da ULA de 32 bits.|
| `decod.vhd`          | Decodificador genérico (ex: 2x4 ou 3x8, dependendo do uso em aula).       |
| `fulladder.vhd`      | Somador completo de 1 bit (leva em conta carry-in e carry-out).          |
| `halfadder.vhd`      | Meio somador de 1 bit (sem carry-in).                                     |
| `mult2x1.vhd`        | Multiplexador 2x1 com controle por seleção.                               |
| `mult2x1comb.vhd`    | Versão combinacional do multiplexador 2x1.                               |
| `mult32bits.vhd`     | Módulo de multiplicação para operandos de 32 bits.                        |
| `overflow.vhd`       | Detecção de overflow para operações aritméticas.                          |
| `testbench.vhd`      | Arquivo de testbench para simular e verificar os módulos.                 |

## 🛠️ Uso

Esses módulos podem ser simulados em ferramentas como o **ModelSim**, **GHDL**, **Vivado**, entre outras. Use o `testbench.vhd` como ponto de partida para validar o comportamento dos componentes individualmente.

## 🧑‍🏫 Finalidade

Projeto desenvolvido com fins **educacionais**, auxiliando no aprendizado de **arquitetura de computadores**, **sistemas digitais** e **projeto de hardware com VHDL**.

---

