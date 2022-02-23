---
title: Instalación de VirtualBox
authors:
- Andrés Leonardo Hernández Bermúdez
---

# Instalación de VirtualBox

!!! note
    - Si ya instalaste tu VirtualBox, crea tus máquinas virtuales [la siguiente página](../debian-install)

--------------------------------------------------------------------------------

### Extensiones de virtualización

Habilitar las extensiones de virtualización en el BIOS o configuración de UEFI

#### Heading 4

- Esto depende de la máquina, consultar el manual de servicio

##### Linux

- En Linux revisar las características del CPU

```bash
tonejito@linux:~$ grep --color 'vmx' /proc/cpuinfo | tail -n 1
```

##### macOS

- En macOS revisar si el procesador tiene la característica `VMX`

```bash
tonejito@macOS ~ % sysctl -a | grep 'machdep.cpu.features:' | grep --color=auto 'VMX'
machdep.cpu.features: FPU VME DE PSE TSC MSR PAE MCE CX8 APIC SEP MTRR PGE MCA
CMOV PAT PSE36 CLFSH DS ACPI MMX FXSR SSE SSE2 SS HTT TM PBE SSE3 PCLMULQDQ
DTES64 MON DSCPL VMX SMX EST TM2 SSSE3 FMA CX16 TPR PDCM SSE4.1 SSE4.2 x2APIC
MOVBE POPCNT AES PCID XSAVE OSXSAVE SEGLIM64 TSCTMR AVX1.0 RDRAND F16C
```

##### Windows

- En Windows se puede ver si está habilitado utilizando el administrador de tareas

![](img/windows-task_manager-virt.png)

- Otra opción es ejecutar el siguiente comando en PowerShell

```PowerShell
PS C:\> Get-ComputerInfo -property "HyperV*"

HyperVisorPresent                                 : True
HyperVRequirementDataExecutionPreventionAvailable : True
HyperVRequirementSecondLevelAddressTranslation    : True
HyperVRequirementVirtualizationFirmwareEnabled    : True
HyperVRequirementVMMonitorModeExtensions          : True
```
