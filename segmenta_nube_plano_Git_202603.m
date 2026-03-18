%%% Example to read a point cloud as a text file, and then segment using a
%%% plane defined by a line on the plane of two axis and the third axis
%%% perpendicular. The plane would be defined by two generating vectors.The example shown here defines a
%%% line on the XY plane, and keeps the Z axis perpendicular
files = {
    'prism.txt'
    };

% Guardamos la nube segmentada en un archivo.
% NOMBRE DEL ARCHIVO SEGMENTADO
fid = fopen('seg-prism.txt', 'w');

% Calculamos el total de archivos
aux=size(files);
totfiles=aux(1);
totfiles

B=[];

temp=char(files(1));
fp=fopen(temp);
if (fp>0)
    A=fscanf(fp,'%e');

    B=[B; A];
    fclose(fp);
end

% Bloque para cuando trae 3 coordenadas el archivo pcd en txt.
N=size(B,1)/3;

B=reshape(B,3,N);

B=B';

X=B(:,1);
Y=B(:,2);
Z=B(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAFICACION DE LA NUBE DE PUNTOS en 3D
figure;
h=plot3(X,Y,Z,'r.');
grid;
axis square;
hold on;
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SEGMENTACION USANDO UN PLANO DEFINIDO DE ACUERDO AL SEMIPLANO QUE SE
% QUIERE ELIMINAR DE LA NUBE

N2=0; %Numero de puntos inicial de la nueva nube

% Proporcionamos los 2 puntos base que definen una recta y a su vez un
% plano, ya que será independiente de Z

%     x1=  0.25;  y1=-1; % input punto 1 % estos puntos para las y
%     dificiles que se tuvo que hacer reflexion sobre el eje vertical
%     x2=  0.3;   y2= -1; % input punto 2

x1=  -1;   y1=-2; % input punto 1
x2=   1;   y2= 2; % input punto 2

m = (y2-y1)/(x2-x1);

for i=1:N
    % Cuando se pone >0 deja la parte superior de la nube y elimina lo
    % que esta abajo del plano.
    %
    % Cuando se pone <0 deja la parte inferior de la nube y eliminar lo
    % que esta arriba del plano
    if((Y(i) - m*(X(i)-x1) - y1)>0)
        N2=N2+1;
        XX(N2) = X(i);
        YY(N2) = Y(i);
        ZZ(N2) = Z(i);
    end;
end;

% Utilizamos vector columnas:
XX=XX';
YY=YY';
ZZ=ZZ';
N2 % imprimimos el total de puntos despuès de la segmentación

%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % GRAFICACION DE LA NUBE DE PUNTOS en 3D, despues de la segmentaciòn
%     % y sin normalizar en traslaciòn, ni escala
figure;
h3=plot3(XX,YY,ZZ,'r.');
grid;
axis square;
hold on;
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');

% Escribimos en un archivo la nube segmentada
for i=1:N2
    fprintf(fid,'%f %f %f \r\n ', XX(i), YY(i), ZZ(i));
end;

% Cerramos el archivo donde se guarda la nube segmentada
fclose(fid);