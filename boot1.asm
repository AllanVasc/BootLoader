org 0x7c00          ;soma ao offset
jmp 0x0000:start    ;CS:IP (CS == 0)

;https://en.wikipedia.org/wiki/INT_13H

start:

    xor ax, ax  ; Zera o registrador ax (xor eh mais rapido que mov)
    mov ds, ax  ; Ds nao pode ser zerado com o xor
    mov es, ax  ; Tambem zerando

    mov ax, 0x50 ;0x50<<1 = 0x500 (início de boot2.asm)
    mov es, ax
    xor bx, bx   ;posição = es<<1+bx

    jmp reset

reset:

    mov ah, 00h ;reseta o controlador de disco junto com a interrupção 13h
    mov dl, 0   ;floppy disk
    int 13h     ;Interrupção de acesso ao disco

    jc reset    ;se o acesso falhar, o CF é setado e tenta novamente

    jmp load_Boot2

load_Boot2:

    mov ah, 02h ;Colocando AH = 02h e int 13H, lê um setor do disco
    mov al, 1   ;quantidade de setores ocupados pelo boot2
    mov ch, 0   ;track 0
    mov cl, 2   ;sector 2
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0

                ;O endereço de interesse é o es:bx
                ;O boot2 está escrito em 0x0500(físico)
                ;assim, deseja-se ler 0050:0000 -> (0x0050 << 1)+0x0000 -> 0x00500 + 0x0000 -> 0x00500

    int 13h     ;interrupção de acesso ao disco

    jc load_Boot2     ;se o acesso falhar, o CF é setado e tenta novamente

    jmp 0x500   ;pula para o setor de endereco 0x500 (start do Boot2)

times 510-($-$$) db 0   ;512 bytes, zera o resto do bootsector 
dw 0xaa55               ;Coloca a assinatura de boot no final do setor (x86 : little endian)