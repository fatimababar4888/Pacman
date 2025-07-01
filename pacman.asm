INCLUDE Irvine32.inc
includelib winmm.lib

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

.data
SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
file BYTE "C:\Hasan\Desktop\coalmusic.wav" , 0


    CreateFile PROTO,           ; create new file
    pFilename:PTR BYTE,     ; ptr to filename
    accessMode:DWORD,       ; access mode
    shareMode:DWORD,        ; share mode
    lpSecurity:DWORD,       ; can be NULL
    howToCreate:DWORD,      ; how to create the file
    attributes:DWORD,       ; file attributes
    htemplate:DWORD         ; handle to template file

    ReadFile PROTO,           ; read buffer from input file
    fileHandle:DWORD,     ; handle to file
    pBuffer:PTR BYTE,     ; ptr to buffer
    nBufsize:DWORD,       ; number bytes to read
    pBytesRead:PTR DWORD, ; bytes actually read
    pOverlapped:PTR DWORD ; ptr to asynchronous info

    stats_array byte 5 dup(9 dup('='))
    file_handle dword ?
    file_name byte "C:\Hasan\Desktop\playerscores.txt",0
    temp_stats_array1 byte 9 dup('=')
    temp_stats_array2 byte 9 dup('=')

    A0 byte 0
    A1 byte 0
    A2 byte 0
    p_n byte 10 dup(0)
    askname db "Enter your name: ",0

ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0

temp byte ?

menu1 db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                            ------      -       --     --        --       -        --       --                        |",0ah  
      db "|                            |    |     / \     /  \    | \      / |      / \       | \       |                        |",0ah
      db "|                            |    |    /   \   /    |   |  \    /  |     /   \      |  \      |                        |",0ah 
      db "|                            |    /   /     \  |        |   \  /   |    /     \     |   \     |                        |",0ah
      db "|                            |----    |-----|  |        |    --    |    |-----|     |    \    |                        |",0ah
      db "|                            |        |     |  \    |   |          |    |     |     |     \   |                        |",0ah
      db "|                            |        |     |   \__/    |          |    |     |     |      \__|                        |",0ah
      db "|                            ------------------------------------------------------------------                        |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                     Press 1 to Play                                                  |",0ah
      db "|                                                 Press 2 for Instructions                                             |",0ah
      db "|                                                     Press 3 to Exit                                                  |",0ah
      db "|                                                  Press 4 for Highscores                                              |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

inst1 db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah 
      db "|                                                  Use W key to move up                                                |",0ah
      db "|                                                 Use A key to move left                                               |",0ah
      db "|                                                 Use D key to move right                                              |",0ah
      db "|                                                 Use S key to move down                                               |",0ah
      db "|                                                  Press X to exit game                                                |",0ah
      db "|                                                 Press P to pause game                                                |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                             Eat the * coins to increase score                                        |",0ah
      db "|                                                    You have 3 lives                                                  |",0ah
      db "|                                                  Survive the 3 levels                                                |",0ah
      db "|                                                 And avoid the ghosts!!                                               |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

leone db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|                      ##             ########   #             #  ########   ##                ###                     |",0ah 
      db "|                      ##             #           #           #   #          ##               #  #                     |",0ah
      db "|                      ##             #            #         #    #          ##              #   #                     |",0ah
      db "|                      ##             ########      #       #     ########   ##                  #                     |",0ah
      db "|                      ##             #              #     #      #          ##                  #                     |",0ah
      db "|                      ##             #               #   #       #          ##                  #                     |",0ah
      db "|                      ##             #                # #        #          ##                  #                     |",0ah
      db "|                      ##########     ########          #         ########   ###########      ######                   |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

maone db "                                                                                                                        ",0ah
      db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|            #                   #             #                  #           #                             #          |",0ah  
      db "|    *       #                    #           #                   #           #                   *         #   *      |",0ah
      db "|            #                     #     *   #        *           #    *      #                             #          |",0ah 
      db "|            #                      #       #                     #           #                             #          |",0ah
      db "|    *       #############           #     #                  #           #                     ############           |",0ah
      db "|                                                             #           #                                            |",0ah
      db "|                                                             #           #                  *                         |",0ah
      db "|##########                    *                #                        #                                             |",0ah
      db "|                                               #                                                                      |",0ah
      db "|                                               #                                                                      |",0ah
      db "|     *                ###############          #             #       *                  ###############               |",0ah
      db "|                    #                          #             #                                        #               |",0ah
      db "|                   #                           #             #                                         #     *        |",0ah
      db "|                  #                            #             #                                          #             |",0ah
      db "|                 #                    *        #             #      *          ####      *               #            |",0ah
      db "|                #                              #     *       #                #                           #           |",0ah
      db "|      *        #       *                       #             #               #                             #          |",0ah
      db "|              #                                #             #              #                               #         |",0ah
      db "|                                               *                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0


letwo db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|                     ##             ########   #             #  ########   ##                ####                     |",0ah 
      db "|                     ##             #           #           #   #          ##               #    #                    |",0ah
      db "|                     ##             #            #         #    #          ##              #     #                    |",0ah
      db "|                     ##             ########      #       #     ########   ##                   #                     |",0ah
      db "|                     ##             #              #     #      #          ##                 #                       |",0ah
      db "|                     ##             #               #   #       #          ##                #                        |",0ah
      db "|                     ##             #                # #        #          ##               #                         |",0ah
      db "|                     ##########     ########          #         ########   ###########     ########                   |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

matwo db "                                                                                                                        ",0ah
      db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|              #                     #                                #     #                                          |",0ah  
      db "|    *          #       j           #                                #       #          *                       *      |",0ah
      db "|                #                 #                   *            #   *     #                                        |",0ah 
      db "|                 #               #                                #           #                                       |",0ah
      db "|    *              #######   ####             # # #              #             #              # # #             #     |",0ah
      db "|                                             #     #            #               #           #      #            #     |",0ah
      db "|#                                           #       #          #                 #         #    *   #           #     |",0ah
      db "| #                   *                       #     #          # ############     ##                #          #       |",0ah
      db "|  #######                                     # # #                                           # # #          #        |",0ah
      db "|         #                                                                                                 #          |",0ah
      db "|     *    #                                          *                                                    #           |",0ah
      db "|           #                                                                      ####                    #           |",0ah
      db "|            #                      #   #######   #                             # #    # #                  #   j      |",0ah
      db "|             #                    #               #                          #           #                  #         |",0ah
      db "|              #                  #     *           #                *       #             #                  # # # # #|",0ah
      db "|               #                #                   #                      #               #                          |",0ah
      db "|      *        #       *       #               *     #                              *                 *               |",0ah
      db "|               #              #                       #                  #                   #                        |",0ah
      db "|                             #                         #                #                     #                       |",0ah
      db "|                            #                           #              #                       #                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0


lethr db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|                     ##             ########   #             #  ########   ##                ####                     |",0ah 
      db "|                     ##             #           #           #   #          ##               #    #                    |",0ah
      db "|                     ##             #            #         #    #          ##                    #                    |",0ah
      db "|                     ##             ########      #       #     ########   ##                   #                     |",0ah
      db "|                     ##             #              #     #      #          ##                 #                       |",0ah
      db "|                     ##             #               #   #       #          ##                   #                     |",0ah
      db "|                     ##             #                # #        #          ##              #     #                    |",0ah
      db "|                     ##########     ########          #         ########   ###########      #####                    |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0


mathr db "                                                                                                                        ",0ah
      db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                              #         #                                                             |",0ah  
      db "|                       *                      #   j     #                             *                     *         |",0ah
      db "|                                              #####  ####     *                                                       |",0ah 
      db "|                                                                                                                      |",0ah
      db "|    *       #####           #########                                           #########      #########              |",0ah
      db "|                ##          #                                                   #              #                      |",0ah
      db "|                ##          #    *                    ####  ###                 #  *           #   *                  |",0ah
      db "|                ##          #                         #     #  #                #              #                      |",0ah
      db "|                ##          #########                 #     #  #                #########      #########              |",0ah
      db "|                ##                  #                 ###   ###                 #       #               #             |",0ah
      db "|     *          ##                  #                 #     #  #                #       #               #             |",0ah
      db "|                ##           j      #                 #     ###                 #       #       *       #             |",0ah
      db "|                ##                  #                                           #       #               #          *  |",0ah
      db "|           ###########      #########                  *                        #########      #########              |",0ah
      db "|                                       *                           *                                                  |",0ah
      db "|                                                                                                                      |",0ah
      db "|                   *                            ######### * ##########                      *             *           |",0ah
      db "|     *                                         #                      #                                               |",0ah
      db "|                                               #  *   *    *   *   *  #                                               |",0ah
      db "|                                               #                      #                                               |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

endsc db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|           ######              ##          #               #  ########        ##     #       # ######## #######       |",0ah 
      db "|          #                   #  #         ##             ##  #              #  #    #       # #        #      #      |",0ah
      db "|         #                   #    #        # #           # #  #             #    #    #     #  #        #      #      |",0ah
      db "|        #                   #      #       #  #         #  #  #            #      #   #     #  #        #      #      |",0ah
      db "|        #                  #        #      #   #       #   #  ######      #        #   #   #   ######   #######       |",0ah
      db "|         #       ###      ############     #    #     #    #  #            #      #    #   #   #        ####          |",0ah
      db "|          #        #     #            #    #     #   #     #  #             #    #      # #    #        #   ##        |",0ah
      db "|           #       #    #              #   #      # #      #  #              #  #       # #    #        #    ##       |",0ah
      db "|            ########   #                #  #       #       #  ########        ##         #     ######## #     ##      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0

winsc db "------------------------------------------------------------------------------------------------------------------------",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah  
      db "|                                                                                                                      |",0ah
      db "|          ######              ##          #               #  ########      #               #    ##     #       #      |",0ah 
      db "|         #                   #  #         ##             ##  #             #               #   #  #    ##      #      |",0ah
      db "|        #                   #    #        # #           # #  #              #             #   #    #   # #     #      |",0ah
      db "|       #                   #      #       #  #         #  #  #               #           #   #      #  #  #    #      |",0ah
      db "|       #                  #        #      #   #       #   #  ######          #     #     #  #        # #   #   #      |",0ah
      db "|        #       ###      ############     #    #     #    #  #                #   # #   #    #      #  #    #  #      |",0ah
      db "|         #        #     #            #    #     #   #     #  #                 # #   # #      #    #   #     # #      |",0ah
      db "|          #       #    #              #   #      # #      #  #                 # #   # #       #  #    #      ##      |",0ah
      db "|           ########   #                #  #       #       #  ########           #     #         ##     #       #      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|                                                                                                                      |",0ah
      db "|______________________________________________________________________________________________________________________|",0ah,0


macur dd ?

strName byte "Name: ",0
strScore BYTE "Your score is: ",0
score BYTE 0
is_powered_up byte 0

strlife BYTE "Your lives: ",0
lives BYTE 3
level byte 1

xPos BYTE 58
yPos BYTE 11

e1xPos BYTE 58
e1yPos BYTE 18
e1direction byte 0

e2xPos BYTE 15
e2yPos BYTE 11
e2direction byte 3

e3xPos BYTE 75
e3yPos BYTE 20
e3direction byte 3


xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?

.code
main PROC
   mov eax, SND_FILENAME  ;; pszSound is a file name
   or eax, SND_LOOP       ;; Play in a loop
   or eax, SND_ASYNC      ;; Play in the background
   invoke PlaySound, addr file, 0, eax
   
   
    mov ebx,GENERIC_READ
    OR ebx,GENERIC_WRITE
    invoke CreateFile ,offset file_name,ebx,0,NULL,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,file_handle
    mov file_handle,eax
    mov eax,file_handle
    call closefile

    mov edx,OFFSET file_name
    call OpenInputFile
    mov file_handle,eax
    
    mov  eax,file_handle
    mov  edx,offset stats_array
    mov  ecx,45
    call readfromfile

    mov eax,file_handle
    call closefile
   
   ;restartgame:
   call menu
    
   call level1    
   call level2
   call level3
   ;jmp restartgame
   invoke ExitProcess, 0

main ENDP

gameover proc
    call clrscr
    mov eax, red
    call settextcolor
    mov edx, offset endsc
    call writestring
    mov eax, yellow
    call settextcolor
    mov edx, offset strName
    call writestring
    mov edx, offset p_n
    call writestring
    call crlf
    mov edx, offset strScore
    call writestring
    mov eax, 0
    mov al, score
    call writeint
    mov eax, 7800
    call delay
    call clrscr
    ret

gameover endp

maze1 proc
    
    mov eax, blue
    call SetTextColor
    mov edx, offset leone
    call WriteString
    mov eax,700
    call Delay
    call clrscr
    
    mov eax,red 
    call SetTextColor
    mov edx, offset maone
    call Writestring


ret
maze1 endp

level1 proc

 call maze1
    
    call DrawPlayer
    mov macur,offset maone

    ;call CreateRandomCoin
    ;call DrawCoin

    ;call Randomize

    gameLoop:

        call enemy1move

        ; getting points:
        mov esi, offset maone
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xpos
        add esi, eax
        mov al, [esi]
        cmp al, "*"
        je scoring
        jne notscoring
        scoring:
            inc score
            mov al,' '
            mov [esi],al
            cmp score,10
            jge endlevel1
        notscoring:
            cmp al,'j'
            je powerup_found
            jne powerup_notfound

        powerup_found:
            mov is_powered_up,1
            add score,5
            mov al,' '
            mov [esi],al
            cmp score,10
            jge endlevel1

        powerup_notfound:
        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteInt

        ;draw lives
        mov dl,20
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlife
        call WriteString
        mov al,lives
        call WriteInt

        onGround:

        ; get user key input:
        mov eax,150
        call delay
        call ReadKey
        jz gameLoop
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar, "p"
        je pausegame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        jmp gameLoop

        moveUp:
        mov esi,offset maone
        movzx eax, ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop

        moveDown:
        mov esi,offset maone
        movzx eax, ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop
        
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

        moveLeft:
        mov esi,offset maone
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop
        
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

        moveRight:
        mov esi,offset maone
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop
        
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop


    jmp gameLoop

    pausegame:
         call ReadChar
         cmp al,"p"
         je gameloop
         jne pausegame
    
    exitGame:
        call clrscr
        call gameover
        exit
    endlevel1:
ret
level1 endp

maze2 proc
    
    mov eax, green
    call SetTextColor
    mov edx, offset letwo
    call WriteString
    mov eax,700
    call Delay
    call clrscr
    
    mov eax,blue 
    call SetTextColor
    mov edx, offset matwo
    call Writestring


ret
maze2 endp

level2 proc
    call clrscr
    call maze2
    mov xpos,58
    mov ypos,11
    ;mov score,0
    ;mov lives,3
    mov level,2
    mov is_powered_up,0
    mov macur,offset matwo

    call DrawPlayer

    ;call CreateRandomCoin
    ;call DrawCoin

    ;call Randomize

    gameLoop2:

        call enemy1move
        call enemy3move

        ; getting points:
        mov esi, offset matwo
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xpos
        add esi, eax
        mov al, [esi]
        cmp al, "*"
        je scoring2
        jne notscoring2
        scoring2:
            inc score
            mov al,' '
            mov [esi],al
            cmp score,20
            jge endlevel2
        notscoring2:
            cmp al,'j'
            je powerup_found2
            jne powerup_notfound2

        powerup_found2:
            mov is_powered_up,1
            add score,5
            mov al,' '
            mov [esi],al
            cmp score,20
            jge endlevel2

        powerup_notfound2:

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteInt

        ;draw lives
        mov dl,20
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlife
        call WriteString
        mov al,lives
        call WriteInt

        onGround2:

        ; get user key input:
        mov eax,150
        call delay
        call ReadKey
        jz gameLoop2
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame2

        cmp inputChar, "p"
        je pausegame2

        cmp inputChar,"w"
        je moveUp2

        cmp inputChar,"s"
        je moveDown2

        cmp inputChar,"a"
        je moveLeft2

        cmp inputChar,"d"
        je moveRight2

        jmp gameLoop2

        
        moveUp2:
        mov esi,offset matwo
        movzx eax, ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop2

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop2

        moveDown2:
        mov esi,offset matwo
        movzx eax, ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop2
        
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop2

        moveLeft2:
        mov esi,offset matwo
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop2
        
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop2

        moveRight2:
        mov esi,offset matwo
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameloop2
        
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop2


    jmp gameLoop2

    pausegame2:
         call ReadChar
         cmp al,"p"
         je gameloop2
         jne pausegame2

    exitGame2:
        call clrscr
        call gameover

    endlevel2:
        call clrscr

ret
level2 endp


maze3 proc
    
    mov eax, green
    call SetTextColor
    mov edx, offset lethr
    call WriteString
    mov eax,700
    call Delay
    call clrscr
    
    mov eax,brown 
    call SetTextColor
    mov edx, offset mathr
    call Writestring


ret
maze3 endp

level3 proc
    call clrscr
    call maze3
    mov xpos,58
    mov ypos,11
    ;mov score,0
    ;mov lives,3
    mov level,3
    mov is_powered_up,0
    mov macur,offset mathr

    call DrawPlayer

    ;call CreateRandomCoin
    ;call DrawCoin

    ;call Randomize

    gameLoop3:

        call enemy1move
        call enemy2move
        call enemy3move

        ; getting points:
        mov esi, offset mathr
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xpos
        add esi, eax
        mov al, [esi]
        cmp al, "*"
        je scoring3
        jne notscoring3
        scoring3:
            inc score
            mov al,' '
            mov [esi],al
            cmp score,35
            jge exitwin
        notscoring3:
            cmp al,'j'
            je powerup_found3
            jne powerup_notfound3

        powerup_found3:
            mov is_powered_up,1
            add score,5
            mov al,' '
            mov [esi],al
            cmp score,35
            jge exitwin

        powerup_notfound3:

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteInt

        ;draw lives
        mov dl,20
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlife
        call WriteString
        mov al,lives
        call WriteInt

        onGround3:

        ; get user key input:
        mov eax,150
        call delay
        call ReadKey
        jz gameLoop3
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame3

        cmp inputChar, "p"
        je pausegame3

        cmp inputChar,"w"
        je moveUp3

        cmp inputChar,"s"
        je moveDown3

        cmp inputChar,"a"
        je moveLeft3

        cmp inputChar,"d"
        je moveRight3


        jmp gameLoop3

        
        moveUp3:
        cmp yPos,2
        jne no_teleport_up
        
        call UpdatePlayer
        mov yPos,21
        call DrawPlayer
        jmp gameLoop3

        no_teleport_up:
        mov esi,offset mathr
        movzx eax, ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameLoop3

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop3

        moveDown3:
        cmp yPos,21
        jne no_teleport_down
        
        call UpdatePlayer
        mov yPos,2
        call DrawPlayer
        jmp gameLoop3

        no_teleport_down:
        mov esi,offset mathr
        movzx eax, ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, xPos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameLoop3
        
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop3

        moveLeft3:
        cmp xPos,1
        jne no_teleport_left
        
        call UpdatePlayer
        mov xPos,118
        call DrawPlayer
        jmp gameLoop3

        no_teleport_left:
        mov esi,offset mathr
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameLoop3
        
        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop3

        moveRight3:
        cmp xPos,118
        jne no_teleport_right

        call UpdatePlayer
        mov xPos,1
        call DrawPlayer
        jmp gameLoop3

        no_teleport_right:
        mov esi,offset mathr
        movzx eax, ypos
        imul eax,121
        add esi,eax
        movzx eax, xPos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je gameLoop3
        
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop3


    jmp gameLoop3

    pausegame3:
         call ReadChar
         cmp al,"p"
         je gameLoop3
         jne pausegame3

    exitwin:
        call clrscr
        mov eax, blue
        call settextcolor
        mov edx, offset winsc
        call writestring
        mov eax, yellow
        call settextcolor
        mov edx, offset strName
        call writestring
        mov edx, offset p_n
        call writestring
        call crlf
        mov edx, offset strScore
        call writestring
        mov eax, 0
        mov al, score
        call writeint
        mov eax, 7800
        call delay
        call clrscr
        jmp level3end

    exitGame3:
        call gameover

    level3end:
        ;;;;;;;;;;;;;;;;;; FILE HANDLING

      mov  edx,OFFSET file_name
      call CreateOutputFile
      mov  file_handle, EAX

              mov al,score
              mov esi,offset A2

              mov ecx,3
              digit_sep:
                  mov ah,0
                  mov bl,10
                  div bl
                  add ah,'0'
                  mov byte ptr [esi],ah
                  sub esi,1
              LOOP digit_sep


            mov esi,offset stats_array
            mov ecx,5
            mov ebx,0
            p_l:
                mov al,'='
                cmp [esi],al
                je p_h

                mov al,A0
                cmp [esi+5],al
                jb p_h
                ja p_l_skip
                mov al,A1
                cmp [esi+6],al
                jb p_h
                ja p_l_skip
                mov al,A2
                cmp [esi+7],al
                jb p_h

                p_l_skip:
                add esi,9
                inc ebx
            LOOP p_l

    
            mov eax,file_handle
            call closefile
            ret


            p_h:

                mov ebp,0
                mov ecx,9
                temp_loop_1:
                    mov al,[esi+ebp]
                    mov temp_stats_array2[ebp],al
                    inc ebp
                LOOP temp_loop_1

                mov ebp,0
                mov ecx,5
                input_name_loop:
                    mov al,p_n[ebp]
                    mov byte ptr [esi+ebp],al
                    inc ebp
                LOOP input_name_loop
                mov al,A0
                mov byte ptr [esi+5],al
                mov al,A1
                mov byte ptr [esi+6],al
                mov al,A2
                mov byte ptr [esi+7],al
                mov al,'0'
                add al,level
                mov byte ptr [esi+8],al

                add esi,9

                mov ecx,4
                sub ecx,ebx
                s_l:

                    mov ebx,ecx
                    mov ebp,0
                    mov ecx,9
                    temp_loop_2:
                        mov al,[esi+ebp]
                        mov temp_stats_array1[ebp],al
                        inc ebp
                    LOOP temp_loop_2
                    
                    mov ebp,0
                    mov ecx,9
                    temp_loop_3:
                        mov al,temp_stats_array2[ebp]
                        mov [esi+ebp],al
                        inc ebp
                    LOOP temp_loop_3
                    
                    mov ebp,0
                    mov ecx,9
                    temp_loop_4:
                        mov al,temp_stats_array1[ebp]
                        mov temp_stats_array2[ebp],al
                        inc ebp
                    LOOP temp_loop_4

                mov ecx,ebx
                add esi,9
                LOOP s_l
        

            mov  eax,file_handle
            mov  edx,offset stats_array
            mov  ecx,lengthof stats_array
            call writetoFile

            mov eax,file_handle
            call closefile

        ;;;;;;;;;;;;;;;;;; FILE HANDLING END



ret
level3 endp

menu proc
    begin:
        mov eax,yellow 
        call SetTextColor
        mov edx, offset menu1
        call WriteString

        call readint
        cmp eax,1
        je gamestart
        
        cmp eax,2
        je instruct

        cmp eax,3
        je exitg

        cmp eax,4
        je showscores


    call clrscr
    showscores:
        call player_scoress
        jmp begin
    
    instruct:
        call instructions
        jmp begin
    
    exitg:
        call clrscr
        exit

    gamestart:
        call clrscr
        mov edx, offset askname
        call writestring

        mov edx, offset p_n
        mov ecx, 10
        call readstring
        call clrscr

    ret
menu endp

instructions proc
    call clrscr
    mov eax,yellow
    call SetTextColor
    mov edx,offset inst1
    call writestring
    mov eax, 7800 
    call Delay
    call clrscr

ret
instructions endp

player_scoress proc
    call clrscr
    mov eax,white
    call SetTextColor
    mov edx,offset stats_array
    call writestring
    mov eax, 7800 
    call Delay
    call clrscr

ret
player_scoress endp

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor

        
    mov dl,xPos
    cmp e1xPos,dl
    jne checke2col
    mov dl,yPos
    cmp e1yPos,dl
    jne checke2col

    ; collision with e1
    cmp is_powered_up,1
    jne player_respawn

    mov e1xPos,67
    mov e1yPos,11
    jmp no_ghost_hit_player

    checke2col:
    mov dl,xPos
    cmp e2xPos,dl
    jne checke3col
    mov dl,yPos
    cmp e2yPos,dl
    jne checke3col

    ; collision with e2
    cmp is_powered_up,1
    jne player_respawn

    mov e2xPos,67
    mov e2yPos,11
    jmp no_ghost_hit_player

    checke3col:
    mov dl,xPos
    cmp e3xPos,dl
    jne no_ghost_hit_player
    mov dl,yPos
    cmp e3yPos,dl
    jne no_ghost_hit_player

    cmp is_powered_up,1
    jne player_respawn

    mov e3xPos,67
    mov e3yPos,11
    jmp no_ghost_hit_player

    player_respawn:
        dec lives
        cmp lives,0
        je exitg
        jne notexit
        exitg:
            call clrscr
            call gameover
            exit
        notexit:
        mov xPos,58
        mov yPos,11
        jmp no_ghost_hit_player
        

    ; collision with e3

    no_ghost_hit_player:
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"C"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
	

	cmp xPos,1
	jle leftborder
	cmp xPos,118
	jge rightborder

	cmp yPos,2
	jle topborder
	cmp yPos,21
	jge endborder

	jmp return_updateplayer

	leftborder:
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc xPos
	jmp return_updateplayer

	rightborder:
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec xPos
	jmp return_updateplayer

	topborder:
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc yPos
	jmp return_updateplayer

	endborder:
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec yPos
	jmp return_updateplayer

return_updateplayer:
	mov dl,xPos
	mov dh,yPos
	call Gotoxy
	mov al," "
	call WriteChar

ret
UpdatePlayer ENDP


DrawEnemy1 PROC
    ; draw enemy at (e1xPos,e1yPos):
    mov eax,white ;(blue*16)
    call SetTextColor

    mov dl,xPos
    cmp e1xPos,dl
    jne no_player_hit_e1
    mov dl,yPos
    cmp e1yPos,dl
    jne no_player_hit_e1

    cmp is_powered_up,1
    je death_e1

    dec lives
    cmp lives,0
    je exitg
    jne notexit
    exitg:
        call clrscr
        call gameover
        exit
    notexit:
    mov xPos,58
    mov yPos,11
    jmp no_player_hit_e1

    death_e1:
        mov e1xPos,67
        mov e1yPos,11


    no_player_hit_e1:
    mov dl,e1xPos
    mov dh,e1yPos
    call Gotoxy
    mov eax, white
    call settextcolor
    mov al,"@"
    call WriteChar
    ret
DrawEnemy1 ENDP

UpdateEnemy1 PROC

	cmp e1xPos,1
	jle e1leftborder
	cmp e1xPos,118
	jge e1rightborder

	cmp e1yPos,2
	jle e1topborder
	cmp e1yPos,21
	jge e1endborder

	jmp return_updateenemy1

	e1leftborder:
	mov dl,e1xPos
	mov dh,e1yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e1xPos
	jmp return_updateenemy1

	e1rightborder:
	mov dl,e1xPos
	mov dh,e1yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e1xPos
	jmp return_updateenemy1

	e1topborder:
	mov dl,e1xPos
	mov dh,e1yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e1yPos
	jmp return_updateenemy1

	e1endborder:
	mov dl,e1xPos
	mov dh,e1yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e1yPos
	jmp return_updateenemy1

return_updateenemy1:
	mov dl,e1xPos
	mov dh,e1yPos
	call Gotoxy
	mov al," "
	call WriteChar

ret
UpdateEnemy1 ENDP


enemy1move proc

        cmp e1direction,1
        je e1moveUp

        cmp e1direction,3
        je e1moveDown

        cmp e1direction,0
        je e1moveLeft

        cmp e1direction,2
        je e1moveRight

        e1moveUp:
        mov esi,macur
        movzx eax, e1ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, e1xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e1newdirection
        cmp al, "-"
        je e1newdirection
        cmp al, "|"
        je e1newdirection
        cmp al, "_"
        je e1newdirection

        call UpdateEnemy1
        dec e1ypos
        call DrawEnemy1
        jmp e1newdirectionmaybe

        e1moveDown:
        mov esi,macur
        movzx eax, e1ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, e1xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e1newdirection
        cmp al, "-"
        je e1newdirection
        cmp al, "|"
        je e1newdirection
        cmp al, "_"
        je e1newdirection
        
        call updateenemy1
        inc e1ypos
        call drawenemy1
        jmp e1newdirectionmaybe

        e1moveLeft:
        mov esi,macur
        movzx eax, e1ypos
        imul eax,121
        add esi,eax
        movzx eax, e1xpos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e1newdirection
        cmp al, "-"
        je e1newdirection
        cmp al, "|"
        je e1newdirection
        cmp al, "_"
        je e1newdirection
        
        call updateenemy1
        dec e1xpos
        call drawenemy1
        jmp e1newdirectionmaybe

        e1moveRight:
        mov esi,macur
        movzx eax, e1ypos
        imul eax,121
        add esi,eax
        movzx eax, e1xpos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e1newdirection
        cmp al, "-"
        je e1newdirection
        cmp al, "|"
        je e1newdirection
        cmp al, "_"
        je e1newdirection
        
        call updateenemy1
        inc e1xpos
        call drawenemy1
        jmp e1newdirectionmaybe

        e1newdirectionmaybe:
        mov eax, 10
        call RandomRange
        cmp eax,1
        jne e1wall
        e1newdirection:
        mov eax, 3
        call RandomRange
        mov e1direction, al


        e1wall:


ret
enemy1move endp

DrawEnemy2 PROC
    ; draw enemy at (e2xPos,e2yPos):
    mov eax,white ;(blue*16)
    call SetTextColor

    
    mov dl,xPos
    cmp e2xPos,dl
    jne no_player_hit_e2
    mov dl,yPos
    cmp e2yPos,dl
    jne no_player_hit_e2

    cmp is_powered_up,1
    je death_e2
    
    dec lives
    cmp lives,0
    je exitg
    jne notexit
    exitg:
        call clrscr
        call gameover
        exit
    notexit:
    
    mov xPos,58
    mov yPos,11
    jmp no_player_hit_e2

    death_e2:
        mov e2xPos,67
        mov e2yPos,11


    no_player_hit_e2:
    mov dl,e2xPos
    mov dh,e2yPos
    call Gotoxy
    mov eax, red
    call settextcolor
    mov al,"@"
    call WriteChar
    ret
DrawEnemy2 ENDP

UpdateEnemy2 PROC

	cmp e2xPos,1
	jle e2leftborder
	cmp e2xPos,118
	jge e2rightborder

	cmp e2yPos,2
	jle e2topborder
	cmp e2yPos,21
	jge e2endborder

	jmp return_updateEnemy2

	e2leftborder:
	mov dl,e2xPos
	mov dh,e2yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e2xPos
	jmp return_updateEnemy2

	e2rightborder:
	mov dl,e2xPos
	mov dh,e2yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e2xPos
	jmp return_updateEnemy2

	e2topborder:
	mov dl,e2xPos
	mov dh,e2yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e2yPos
	jmp return_updateEnemy2

	e2endborder:
	mov dl,e2xPos
	mov dh,e2yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e2yPos
	jmp return_updateEnemy2

return_updateEnemy2:
	mov dl,e2xPos
	mov dh,e2yPos
	call Gotoxy
	mov al," "
	call WriteChar

ret
UpdateEnemy2 ENDP


Enemy2move proc

        cmp e2direction,1
        je e2moveUp

        cmp e2direction,3
        je e2moveDown

        cmp e2direction,0
        je e2moveLeft

        cmp e2direction,2
        je e2moveRight

        e2moveUp:
        mov esi,macur
        movzx eax, e2ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, e2xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e2newdirection
        cmp al, "-"
        je e2newdirection
        cmp al, "|"
        je e2newdirection
        cmp al, "_"
        je e2newdirection

        call UpdateEnemy2
        dec e2ypos
        call DrawEnemy2
        jmp e2newdirectionmaybe

        e2moveDown:
        mov esi,macur
        movzx eax, e2ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, e2xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e2newdirection
        cmp al, "-"
        je e2newdirection
        cmp al, "|"
        je e2newdirection
        cmp al, "_"
        je e2newdirection
        
        call updateEnemy2
        inc e2ypos
        call drawEnemy2
        jmp e2newdirectionmaybe

        e2moveLeft:
        mov esi,macur
        movzx eax, e2ypos
        imul eax,121
        add esi,eax
        movzx eax, e2xpos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e2newdirection
        cmp al, "-"
        je e2newdirection
        cmp al, "|"
        je e2newdirection
        cmp al, "_"
        je e2newdirection
        
        call updateEnemy2
        dec e2xpos
        call drawEnemy2
        jmp e2newdirectionmaybe

        e2moveRight:
        mov esi,macur
        movzx eax, e2ypos
        imul eax,121
        add esi,eax
        movzx eax, e2xpos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e2newdirection
        cmp al, "-"
        je e2newdirection
        cmp al, "|"
        je e2newdirection
        cmp al, "_"
        je e2newdirection
        
        call updateEnemy2
        inc e2xpos
        call drawEnemy2
        jmp e2newdirectionmaybe

        e2newdirectionmaybe:
        mov eax, 10
        call RandomRange
        cmp eax,1
        jne e2wall
        e2newdirection:
        mov eax, 3
        call RandomRange
        mov e2direction, al


        e2wall:


ret
Enemy2move endp


DrawEnemy3 PROC
    ; draw enemy at (e3xPos,e3yPos):
    mov eax,white ;(blue*16)
    call SetTextColor

    
    mov dl,xPos
    cmp e3xPos,dl
    jne no_player_hit_e3
    mov dl,yPos
    cmp e3yPos,dl
    jne no_player_hit_e3

    cmp is_powered_up,1
    je death_e3
    
    dec lives
    cmp lives,0
    je exitg
    jne notexit
    exitg:
        call clrscr
        call gameover
        exit
    notexit:
    mov xPos,58
    mov yPos,11
    jmp no_player_hit_e3

    death_e3:
        mov e3xPos,67
        mov e3yPos,11


    no_player_hit_e3:
    mov dl,e3xPos
    mov dh,e3yPos
    call Gotoxy
    mov eax, red
    call settextcolor
    mov al,"@"
    call WriteChar
    ret
DrawEnemy3 ENDP

UpdateEnemy3 PROC

	cmp e3xPos,1
	jle e3leftborder
	cmp e3xPos,118
	jge e3rightborder

	cmp e3yPos,2
	jle e3topborder
	cmp e3yPos,21
	jge e3endborder

	jmp return_updateEnemy3

	e3leftborder:
	mov dl,e3xPos
	mov dh,e3yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e3xPos
	jmp return_updateEnemy3

	e3rightborder:
	mov dl,e3xPos
	mov dh,e3yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e3xPos
	jmp return_updateEnemy3

	e3topborder:
	mov dl,e3xPos
	mov dh,e3yPos
	call Gotoxy
	mov al," "
	call WriteChar
	inc e3yPos
	jmp return_updateEnemy3

	e3endborder:
	mov dl,e3xPos
	mov dh,e3yPos
	call Gotoxy
	mov al," "
	call WriteChar
	dec e3yPos
	jmp return_updateEnemy3

return_updateEnemy3:
	mov dl,e3xPos
	mov dh,e3yPos
	call Gotoxy
	mov al," "
	call WriteChar

ret
UpdateEnemy3 ENDP


Enemy3move proc

        cmp e3direction,1
        je e3moveUp

        cmp e3direction,3
        je e3moveDown

        cmp e3direction,0
        je e3moveLeft

        cmp e3direction,2
        je e3moveRight

        e3moveUp:
        mov esi,macur
        movzx eax, e3ypos
        dec eax
        imul eax,121
        add esi,eax
        movzx eax, e3xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e3newdirection
        cmp al, "-"
        je e3newdirection
        cmp al, "|"
        je e3newdirection
        cmp al, "_"
        je e3newdirection

        call UpdateEnemy3
        dec e3ypos
        call DrawEnemy3
        jmp e3newdirectionmaybe

        e3moveDown:
        mov esi,macur
        movzx eax, e3ypos
        inc eax
        imul eax,121
        add esi,eax
        movzx eax, e3xpos
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e3newdirection
        cmp al, "-"
        je e3newdirection
        cmp al, "|"
        je e3newdirection
        cmp al, "_"
        je e3newdirection
        
        call updateEnemy3
        inc e3ypos
        call drawEnemy3
        jmp e3newdirectionmaybe

        e3moveLeft:
        mov esi,macur
        movzx eax, e3ypos
        imul eax,121
        add esi,eax
        movzx eax, e3xpos
        dec eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e3newdirection
        cmp al, "-"
        je e3newdirection
        cmp al, "|"
        je e3newdirection
        cmp al, "_"
        je e3newdirection
        
        call updateEnemy3
        dec e3xpos
        call drawEnemy3
        jmp e3newdirectionmaybe

        e3moveRight:
        mov esi,macur
        movzx eax, e3ypos
        imul eax,121
        add esi,eax
        movzx eax, e3xpos
        inc eax
        add esi, eax
        mov al, [esi]
        cmp al, "#"
        je e3newdirection
        cmp al, "-"
        je e3newdirection
        cmp al, "|"
        je e3newdirection
        cmp al, "_"
        je e3newdirection
        
        call updateEnemy3
        inc e3xpos
        call drawEnemy3
        jmp e3newdirectionmaybe

        e3newdirectionmaybe:
        mov eax, 10
        call RandomRange
        cmp eax,1
        jne e3wall
        e3newdirection:
        mov eax, 3
        call RandomRange
        mov e3direction, al


        e3wall:


ret
Enemy3move endp


END main