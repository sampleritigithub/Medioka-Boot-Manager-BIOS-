[org 0x7c00]
;Custom boot manager
[BITS 16]	;16-Bit real mode code
call ReadDrive
jmp programspace
programspace equ 0x7e00
mov [bootdisk], dl
ReadDrive:
    ; Disk Bootloader Run ;
    ; Not very Important to learn ;
    mov ah, 0x02
    mov bx, programspace
    mov al, 4	 ; Disk Stuff you must do
    mov dl, [bootdisk]
    mov ch, 0x00 ; Cylinder
    mov dh, 0x00 ; Head
    mov cl, 0x02 ; Sector
    int 0x13 ; BIOS Interrupt
    jc DiskReadFailed
    ret

bootdisk:
	db 0 ; Drive data

DiskReadFailed:
	; If the bootloader is missing or corrupted: ;
	mov ah, 0x0e
	mov al, '!'
	int 0x10
	jmp $ 
; BIOS Printing
mov ah, 0x0e
mov al, 'M'
int 0x10
mov ah, 0x0e ; BIOS Interrupt
mov al, 'e' ; Character to print
int 0x10 ; BIOS Interrupt
mov ah, 0x0e
mov al, 'd'
int 0x10
mov ah, 0x0e
mov al, 'B'
int 0x10
mov ah, 0x0e
mov al, 'M'
int 0x10
mov ah, 0x0e
mov al, ' '
int 0x10
mov ah, 0x0e
mov al, 'i'
int 0x10
mov ah, 0x0e
mov al, 's'
int 0x10
mov ah, 0x0e
mov al, ' '
int 0x10
mov ah, 0x0e
mov al, 'S'
int 0x10
mov ah, 0x0e
mov al, 't'
int 0x10
mov ah, 0x0e
mov al, 'a'
int 0x10
mov ah, 0x0e
mov al, 'r'
int 0x10
mov ah, 0x0e
mov al, 't'
int 0x10
mov ah, 0x0e
mov al, 'i'
int 0x10
mov ah, 0x0e
mov al, 'n'
int 0x10
mov ah, 0x0e
mov al, 'g'
int 0x10

jmp $ ; Forever loop

times 510-($-$$) db 0 ; Netwide Assembler Fill-Up

dw 0xAA55 ; Boot Sector
