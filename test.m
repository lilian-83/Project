clc
clear
close all

% cr�ation des donn�es
A=[0 1 1 1 0;0 1 0 1 0;0 0 0 1 1;1 0 0 1 1;1 1 0 0 1];
A=0.5*(A+A'-diag(diag(A)));
G=graph(A);
plot(G);

% ouverture du fichier en �criture
% fileID=fopen('test2.txt','w');

% �criture de x et y selon le format choisi
%fprintf(fileID,G);

% fermeture du fichier
% fclose(fileID);

hgexport(G,'test3');