%importo l'immagine e la converto in scala di grigi
%ricorda che l'immagine deve essere nella stessa cartella di progetto
A = imread("2-4.bmp");
rgb2gray(A);

%trovo l'indice progressivo del massimo (in realtà non mi serve)

i = 1;
currMax = 1;
indexMax =[1 1];
for i = 1:1310719
    if A(i+1) > A(currMax)
        currMax = i+1;
    end
end

%ricavo gli indici del massimo di intensità 
riga = 1;
colonna = 1;


for riga = 1:1024
    colonna = 1;
    for colonna = 1:1279
        if A(riga, colonna+1) > A(indexMax(1,1),indexMax(1,2))
            indexMax = [riga colonna+1];
        end
    end
end
%estrapolo un intorno quadrato del massimo dall'immagine principale 
Deltariga = ((indexMax(1,1)-150):(indexMax(1,1)+150));
Deltacolonna = ((indexMax(1,2)-150):((indexMax(1,2)+150)));
M = A(Deltariga,Deltacolonna);
%stampo nella figura 1 l'intorno
figure(1);
imshow(M);
%effettuo una slice in orizzontale della figura di intensità
Y = (1:301);
X = (1:301);
M = cast(M,"double");
Z = cast(A(indexMax(1,1),Deltacolonna), "double") / ...
    cast(max(max(max(A))), "double");

%il vettore Z contiene la slice che può essere usata per effettuare il fit.


%stampo in 3d la distribuzione di intensità
figure(2);
surf(X,Y,M(Y,X));

figure(3)
plot(Z)















