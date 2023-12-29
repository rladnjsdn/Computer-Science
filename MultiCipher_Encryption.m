indx = 0;
while indx ~= 7

indx = menu('Cipher Options', ... %shows the interface of menu to users
    'Rail Fence', ...
    'Multiplication', ...
    'Caesar', ...
    'Affine', ...
    'Cube', ...
    'Vigenere', ...
    'Quit')

if indx == 1 
    indx_r = 0;
    while indx_r ~= 3
        indx_r = menu('Rail Fence', ... %menus for rail fence
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_r == 1
            text=input("Text to encrypt: ", 's'); 
            railCount=input("Number of rails (integer greater than 1): ");
            encryptedText="";
            rowWord="";
            letters=split(text, '');
            letters(1)=[];
            letters(length(letters))=[];
            for a=length(letters):-1:1
                if letters(a)==[" "]
                    letters(a)=[];
                end
            end
            topRowPositions=[1:(2*railCount-2):length(letters)];
            bottomRowPositions=[railCount:(2*railCount-2):length(letters)];
            for b=topRowPositions
                rowWord=rowWord+letters(b);
            end
            encryptedText=encryptedText+rowWord+" ";
            rowWord="";
            for c=1:railCount-2
                for d=[topRowPositions (topRowPositions(length(topRowPositions))+2*railCount-2)]
                    try
                        rowWord=rowWord+letters(d-c);
                    end
                    try
                        rowWord=rowWord+letters(d+c);
                    end
                end
                encryptedText=encryptedText+rowWord+" ";
                rowWord="";
            end
            for e=bottomRowPositions
                rowWord=rowWord+letters(e);
            end
            encryptedText=encryptedText+rowWord;
            showy("Splicing data");
            showy("Laying tracks");
            showy("Compiling results");
            disp(encryptedText);
        end
        if indx_r == 2
            text=input("Text to decrypt (must have quotation marks): "); %must include " "
            railCount=input("Number of rails (integer greater than 1): ");
            decryptedText="";
            letters=split(text, ' ');
            Word=char(letters(1));
            decryptedText=decryptedText+Word(1);
            Word=string(Word(2:end));
            letters(1)=Word;
            upIndices=2:railCount;
            downIndices=railCount-1:-1:1;
            try
                while true
                    for place=upIndices
                        Word=char(letters(place));
                       decryptedText=decryptedText+Word(1);
                        Word=string(Word(2:end));
                        letters(place)=Word;
                    end
                    for place=downIndices
                        Word=char(letters(place));
                        decryptedText=decryptedText+Word(1);
                        Word=string(Word(2:end));
                        letters(place)=Word;
                    end
                end
            end
            showy("Splicing data");
            showy("Laying tracks");
            showy("Compiling results");
            disp(decryptedText);
        end
    end
end

if indx == 2 
    indx_m = 0;
    while indx_m ~= 3
        indx_m = menu('Multiplication', ... %menus for multiplication cipher
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_m == 1
            dict = dictionary('A',0,'B',1,'C',2,'D',3,'E',4,'F',5,'G',6,'H',7,'I',8,'J',9, ... %sets the values for letters
                'K',10,'L',11,'M',12,'N',13,'O',14,'P',15,'Q',16,'R',17,'S',18,'T',19,'U',20, ...
                'V',21,'W',22,'X',23,'Y',24,'Z',25);
            tcid = dictionary('0','A','1','B','2','C','3','D','4','E','5','F','6','G','7','H','8','I','9', ... %sets the letters to respective numebrs
                'J','10','K','11','L','12','M','13','N','14','O','15','P','16','Q','17','R','18','S','19', ...
                'T','20','U','21','V','22','W','23','X','24','Y','25','Z');
            text = input('Text to encrypt (alphabetical): ', 's');  %input
            key = input('Type a value for multiplication (odd numbers 1-25) : '); %limited values for odds up to 26 (number of letters)
            text2 = upper(text); %capitalization
            text3 = strrep(text2, ' ', ''); %removes spaces
            list = []; %creates initial list
            for i = 1:length(text3) %range
                sth = extract(text3,i); %slice the str
                list = [list, sth]; %appends in the list
                text_num = dict(list); %get the respective values
                text_num_encrypted = mod((text_num * key), 26); %formula for multiplication
                multiplication_encrypted = tcid(text_num_encrypted);
                semifinal_multiplication_encrypted = join(multiplication_encrypted); %ombines sliced letters
                final_multiplication_encrypted = semifinal_multiplication_encrypted.replace(" ", "");
                if length(list) == length(text3) %when all the strings are converted, show the final encrypted text
                    showy("Splicing data");
                    showy("Multiplying");
                    showy("Compiling results");
                    disp(final_multiplication_encrypted);
                else
                    continue;
                end
            end
        end
        if indx_m == 2
            dict = dictionary('A',0,'B',1,'C',2,'D',3,'E',4,'F',5,'G',6,'H',7,'I',8,'J',9, ...
                'K',10,'L',11,'M',12,'N',13,'O',14,'P',15,'Q',16,'R',17,'S',18,'T',19,'U',20, ...
                'V',21,'W',22,'X',23,'Y',24,'Z',25);
            tcid = dictionary('0','A','1','B','2','C','3','D','4','E','5','F','6','G','7','H','8','I','9', ...
                'J','10','K','11','L','12','M','13','N','14','O','15','P','16','Q','17','R','18','S','19', ...
                'T','20','U','21','V','22','W','23','X','24','Y','25','Z');
            text = input('Text to decrypt (alphabetical): ', 's');
            key = input('Type a value of the key (odd numbers 1-25): ');
            text2 = upper(text); %capitalizes the input text
            list = []; 
            for i = 1:length(text2)
                sth = extract(text2,i); %extracts each letters from the string
                list = [list, sth];
            end
            %Finding modular inverse
            A = 0;
            while key < 25
                if mod((key * A), 26) ~= 1
                    A = A + 1;
                elseif mod((key * A), 26) == 1
                    modular_inverse = A;
                    break
                end
            end
            %Decrypting
            text_num = dict(list);
            text_num_decrypted = mod((text_num * modular_inverse), 26); %formula for finding the key value used for multiplication encryption
            multiplication_decrypted = tcid(text_num_decrypted); %convert into alphabets
            semifinal_multiplication_decrypted = join(multiplication_decrypted); %joins the letters to form a string
            final_multiplication_decrypted = semifinal_multiplication_decrypted.replace(" ", ""); %removing spaces
            if length(list) == length(text) %shows the final list when every letters are appended
                showy("Splicing data");
                showy("Multiplying");
                showy("Compiling results");
                disp(final_multiplication_decrypted);
            end
        end
    end
end

if indx == 3 
    indx_sc = 0;
    while indx_sc ~= 3
        indx_sc = menu('Caesar', ... %menus for simple caesar shift
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_sc == 1
            %encryption
            text = input('Text to encrypt: ', 's'); %input of text
            key = input('Type an integer for the key (nonnegative integer): '); %input of key
            text = lower(text); %lower cases of input
            text_num = double(text);
            encrypted = text_num + key; %values of alphabets + key values
            final_encrypted = char(encrypted); %turns the values into alphabets again
            showy("Splicing data");
            showy("Caesaring");
            showy("Compiling results");
            disp(final_encrypted);
        end
        if indx_sc == 2
            %decryption (works the other way around)
            text2 = input('Text to decrypt: ', 's');
            key2 = input('Type an integer for the key (nonnegative integer): ');
            text2 = lower(text2); 
            text_num2 = double(text2);  %converts into numerical values
            decrypted = text_num2 - key2; %formula for simple caesar shift
            final_decrypted = char(decrypted); %converts into characters again
            showy("Splicing data");
            showy("Caesaring");
            showy("Compiling results");
            disp(final_decrypted);
        end
    end
end

if indx == 4 
    indx_a = 0;
    while indx_a ~= 3
        indx_a = menu('Affine', ... %menus for affine cipher
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_a == 1
            dict = dictionary('A',0,'B',1,'C',2,'D',3,'E',4,'F',5,'G',6,'H',7,'I',8,'J',9, ... %sets the alphabets respective to the values again
                'K',10,'L',11,'M',12,'N',13,'O',14,'P',15,'Q',16,'R',17,'S',18,'T',19,'U',20, ...
                'V',21,'W',22,'X',23,'Y',24,'Z',25);
            tcid = dictionary('0','A','1','B','2','C','3','D','4','E','5','F','6','G','7','H','8','I','9', ...
                'J','10','K','11','L','12','M','13','N','14','O','15','P','16','Q','17','R','18','S','19', ...
                'T','20','U','21','V','22','W','23','X','24','Y','25','Z');
            text = input('Text to encrypt (alphabetical): ', 's'); %text to input
            key_slope = input('Type a value for the key of slope (odd numbers 1-25): '); %same with multiplication cipher
            key_intercept = input('Type a value for the key of intercept (integer): '); %additional key to be added
            list = [];
            text2 = upper(text);
            text3 = strrep(text2, ' ', '');
            for i = 1:length(text3)
                sth = extract(text3,i);
                list = [list, sth];
                text_num = dict(list);
                text_num_encrypted = mod(((text_num*key_slope) + key_intercept), 26); %formula for affine cipiher = mx + b where m is the slope and m is the intercept
                affine_encrypted = tcid(text_num_encrypted); %converts into alphabets finding corresponding alphabets from the dictionary
                semifinal_affine_encrypted = join(affine_encrypted);
                final_affine_encrypted = semifinal_affine_encrypted.replace(" ", ""); %remove spaces
                if length(list) == length(text3)
                    showy("Splicing data");
                    showy("Configuring slope intercept result");
                    showy("Compiling results");
                    disp(final_affine_encrypted);
                else
                    continue;
                end
            end
        end
        if indx_a == 2
            %decryption 
            dict = dictionary('A',0,'B',1,'C',2,'D',3,'E',4,'F',5,'G',6,'H',7,'I',8,'J',9, ...
                'K',10,'L',11,'M',12,'N',13,'O',14,'P',15,'Q',16,'R',17,'S',18,'T',19,'U',20, ...
                'V',21,'W',22,'X',23,'Y',24,'Z',25);
            tcid = dictionary('0','A','1','B','2','C','3','D','4','E','5','F','6','G','7','H','8','I','9', ...
                'J','10','K','11','L','12','M','13','N','14','O','15','P','16','Q','17','R','18','S','19', ...
                'T','20','U','21','V','22','W','23','X','24','Y','25','Z');
            text = input('Text to decrypt (alphabetical): ', 's');
            key_slope = input('Type a value for the key of slope (odd numbers 1-25): ');
            key_intercept = input('Type a value for the key of intercept (integer): ');
            text2 = upper(text); %capitalizes the text
            list = []; %creates the list  
            for i = 1:length(text2) %creating list of extracted letters
                sth = extract(text2,i);
                list = [list, sth];
            end
            %Finding modular inverse
            B = 0;
            while key_slope < 25
                if mod((key_slope * B), 26) ~= 1
                    B = B + 1;
                elseif mod((key_slope * B), 26) == 1
                    modular_inverse = B;
                    break
                end
            end
            %Decrypting
            text_num = dict(list);
            text_num_decrypted = mod(((mod(((modular_inverse) * (text_num - key_intercept)), 26))) ,26);
            affine_decrypted = tcid(text_num_decrypted);
            semifinal_affine_decrypted = join(affine_decrypted);
            final_affine_decrypted = semifinal_affine_decrypted.replace(" ", "");
            if length(list) == length(text)
                showy("Splicing data")
                showy("Configuring slope intercept result");
                showy("Compiling results");
                disp(final_affine_decrypted);
            end
        end
    end
 end

if indx == 5
    indx_c = 0;
    while indx_c ~= 3
        indx_c = menu('Cube', ...
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_c == 1           
            inp=string(input("Text to encrypt (all characters except '*'): ", 's'));
            sheetSize=input("Enter your sheet size (positive integer): ")
            inp = strrep(inp, ' ', '');
            output=""; %Initialize output
            textLength=strlength(inp); 
            sheetCount=ceil(textLength/(sheetSize)^2); %Determines sheet count by dividing the total number of characters which is the file length by the size of one sheet which is sheetSize^5 then rounding up with the ceiling function to know how many sheets are needed to fit all the characters with this sheet size
           
           
            arr=split(inp,""); %Split input into array for parsing
            arr(1)=[]; %Deletes empty "" first element of arr acquired from the split so as to not shift how the characters fit into the sheets
            arr(length(arr))=[]; %Deletes empty "" final element of arr acquired from the split so as to not shift how the characters fit into the sheets
            arr=arr';
            cubeSize=sheetCount*sheetSize^2; %cubeSize calculated by multiplying its dimensions
            elementsNeeded=cubeSize-textLength; %Calculate the amount of filler elements needed to fill up the sheets to be able to reshape and transform by using cubeSize, which is the total volume/number of elements of the cube and subtracting the fileLength which is the number of elements available from the file. Filler elements are just "*", what we determined would be one of the least likely characters to appear in the average text
            for addElements=1:elementsNeeded %For loop to add filler elements "elementsNeeded" times
                arr=[arr "*"]; %adds the filler "*" element to the end of the array the number of times the for loop runs
            end %Ends the array filling for loop
           
            cube=reshape(arr, sheetSize, sheetSize, sheetCount); %Set up a cube by reshaping the array into a sheetSize x sheetSize x sheetCount matrix
            
           
            for sheet=1:sheetCount %For loop to parse through sheets and transpose them
                cube(:,:,sheet)=cube(:,:,sheet)'; %Perform matrix transposes sheet by sheet for the cube
            end %End of transposition for loop
          
           
            for pos=1:cubeSize %For loop to add the individual characters to ouput
                output=output+cube(pos); %Add the elements of the cube to output
            end %End output filling loop
            showy("Splicing data");
            showy("Loading cube");
            showy("Rotating");
            showy("Compiling results");
            disp(output); %Writes the output to the outputFile 
        end
        %decryption
        if indx_c == 2
            inp=input("Text to decrypt (all characters): ", 's'); %Reads the text
            sheetSize=input("Enter your sheetSize (positive integer): ");
            output=""; %Initialize output
            textLength=strlength(inp);
            sheetCount=ceil(textLength/(sheetSize)^2); %Determines sheet count by dividing the total number of characters which is the file length by the size of one sheet which is sheetSize^5 then rounding up with the ceiling function to know how many sheets are needed to fit all the characters with this sheet size
                  
            arr=split(inp,""); %Split input into array for parsing
            arr(1)=[]; %Deletes empty "" first element of arr acquired from the split so as to not shift how the characters fit into the sheets
            arr(length(arr))=[]; %Deletes empty "" final element of arr acquired from the split so as to not shift how the characters fit into the sheets
            arr=arr';
            cubeSize=sheetCount*sheetSize^2; %cubeSize calculated by multiplying its dimensions

            cube=reshape(arr, sheetSize, sheetSize, sheetCount); %Set up a cube by reshaping the array into a sheetSize x sheetSize x sheetCount matrix
              
            for sheet=1:sheetCount %For loop to parse through sheets and transpose them
                cube(:,:,sheet)=cube(:,:,sheet)'; %Perform matrix transposes sheet by sheet for the cube
            end %End of transposition for loop
 
            for pos=1:cubeSize %For loop to add the individual characters to ouput
                if cube(pos)~="*" %Excludes filler characters from the decryption
                    output=output+cube(pos); %Add the elements of the cube to output
                end %Ends filler character filter loop
            end %End output filling loop
            showy("Splicing data");
            showy("Loading cube");
            showy("Rotating");
            showy("Compiling results");
            disp(output); 
        end
    end
end

if indx == 6
    indx_v = 0;
    while indx_v ~= 3
        indx_v = menu('Vigenere', ... %menus for vigenere cipher
            'Encryption', ...
            'Decryption', ...
            'Quit')
        if indx_v == 1
            dict = dictionary('A',0,'B',1,'C',2,'D',3,'E',4,'F',5,'G',6,'H',7,'I',8,'J',9, ...
                'K',10,'L',11,'M',12,'N',13,'O',14,'P',15,'Q',16,'R',17,'S',18,'T',19,'U',20, ...
                'V',21,'W',22,'X',23,'Y',24,'Z',25);
            tcid = dictionary('0','A','1','B','2','C','3','D','4','E','5','F','6','G','7','H','8','I','9', ...
                'J','10','K','11','L','12','M','13','N','14','O','15','P','16','Q','17','R','18','S','19', ...
                'T','20','U','21','V','22','W','23','X','24','Y','25','Z');
            
            %setting the table for encryption using matrices
            m = string(('A':'Z').').';
            m2 = [m; circshift(m, -1)];
            m3 = [m2; circshift(m, -2)];
            m4 = [m3; circshift(m, -3)];
            m5 = [m4; circshift(m, -4)];
            m6 = [m5; circshift(m, -5)];
            m7 = [m6; circshift(m, -6)];
            m8 = [m7; circshift(m, -7)];
            m9 = [m8; circshift(m, -8)];
            m10 = [m9; circshift(m, -9)];
            m11 = [m10; circshift(m, -10)];
            m12 = [m11; circshift(m, -11)];
            m13 = [m12; circshift(m, -12)];
            m14 = [m13; circshift(m, -13)];
            m15 = [m14; circshift(m, -14)];
            m16 = [m15; circshift(m, -15)];
            m17 = [m16; circshift(m, -16)];
            m18 = [m17; circshift(m, -17)];
            m19 = [m18; circshift(m, -18)];
            m20 = [m19; circshift(m, -19)];
            m21 = [m20; circshift(m, -20)];
            m22 = [m21; circshift(m, -21)];
            m23 = [m22; circshift(m, -22)];
            m24 = [m23; circshift(m, -23)];
            m25 = [m24; circshift(m, -24)];
            m26 = [m25; circshift(m, -25)];
            
            %inputs 
            text = input('Text to encrypt (alphabetical): ' , 's');
            key = input('Type the keyword (alphabetical): ' , 's');
            text2 = upper(text);
            key2 = upper(key);
            key3 = strrep(key2, ' ', '');
            text3 = strrep(text2, ' ', '');
            list = [];
            for i = 1:length(text3)
                sth = extract(text3,i);
                list = [list, sth];
                text_num = dict(list);
            end
            repetition = ceil(length(text3) / length(key3));
            key4 = repmat(key3, 1, repetition); %repeats the element of array
            key4 = key4(1:length(text3));
            list2 = []; %creates the list
            for j = 1:length(key4)
                nth = extract(key4,j); %extracting each letters from the input text
                list2 = [list2, nth]; %appends each letters into list
                text_num2 = dict(list2); %converts into numerical values
            end
            list3 = [];  
            for k = 1:length(text_num2)
                val = m26(text_num(k)+1, text_num2(k)+1); %finding letters respective to the values of input texts and keys
                list3 = [list3, val];
            end
            semifinal_vigenere_encrypted = join(list3); %combines the letters into a string
            final_vigenere_encrypted = semifinal_vigenere_encrypted.replace(" ", ""); %remove spaces
            showy("Splicing data");
            showy("Configuring correspondence");
            showy("Compiling results");
            disp(final_vigenere_encrypted);
        end
        if indx_v == 2
            %decryption
            text = input('Text to decrypt (alphabetical): ' , 's');
            key = input('Type the keyword (alphabetical): ' , 's');
            text2 = upper(text); %capitalize input text
            key2 = upper(key); %capitalize key
            key3 = strrep(key2, ' ', ''); %removes spaces
            decrypted2 = ''; %create empty str
            index_key = 1;  %assing key for the index
                for i = 1:length(text2) %create an array
                if isletter(text2(i)) 
                    decrypted1 = mod((text2(i) - key3(index_key) + 26), 26) + 'A'; %formula for vigenere cipher decryption
                    decrypted2 = [decrypted2 char(decrypted1)];
                        
                        %move to the next letter in the key
                    index_key = mod(index_key, length(key3)) + 1;
                else
                        %if the character is not a letter, leave it unchanged
                    decrypted2 = [decrypted2 text2(i)];
                end
            end
            showy("Splicing data");
            showy("Configuring correspondence");
            showy("Compiling results");
            disp(decrypted2);
        end
    end
end

end

%Visually appealing display pattern function
function showy(show)
    disp(show+"...");
    pause(1);
    disp("...")
    pause(1);
    disp("...")
    pause(1);
    disp("...")
end
