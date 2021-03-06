% Universidad Simon Bolivar
% Departamento de Electronica y Circuitos
% EC3443/EC4432/EC6432 Comunicaciones Moviles
% ESCEL Entorno de Simulacion CELular version 2017
% Prof. Renny E. Badra
%
%
% Esta version basica usa el modelo de propagacion exponencial
% para estimar el C/I de cada punto de una rejilla de 50m x 50m
% sobre un area a cubrir de 13 km x 14.5 km (ciudad mediana)
% con 20 celdas de radio nominal de 1.5 km cada una
% asumiendo un factor de reuso N=4 y antenas omnidireccionales
% calcula indisponibilidad global
% grafica celda dominante y puntos fuera de cobertura

clear; j=sqrt(-1); pi=3.141592654; format compact;

Pref=-20; dref=10; n=5;
% Pref, dref, n son los parametros del modelo exponencial para las perdidas
% de trayecto (Pref va en dBm, dref va en metros)

sigma=8; %sigma es la desviacion estandar (dB) deseada para el ensombrecimiento

Pr=zeros(1,20);  CI=zeros(260,290); Celda=zeros(260,290,'int8'); 
% Pr(b) es la p�tencia recibida en dBm desde la celda b-esima (se calcula para cada
% punto de la rejilla)
% Celda (x,y) es el �ndice de la celda dominante en el punto de coordenadas x,y
% CI(x,y) es el valor de C/I en dB en el punto de coordenadas x,y

load DATA_ESCELL_2; % Aqu� se carga el archivo previamente generado que contiene BTS y SHAD
% (ultilice el nombre del archivo proporcionado)
% BTS (b) es la coordenada (compleja) de la BTS b-esima  BTS(b) = x + j*y
% posiciones de las celdas se corresponden a una rejilla hexagonal con una
% variabilidad aleatoria del +/- 10% del radio en cada coordenada
% SHAD es una matriz 3D de valores de ensombrecimiento (normalizados) en dB
% SHAD(x,y,b) se refiere a la coordenada x,y respecto a la BTS b-esima
% Los valores de SHAD son enteros y estan escalados por un factor de 80
% Los valores de SHAD poseen correlacion espacial y angular

MASK(1,:)=[0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0];
MASK(2,:)=[0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0];
MASK(3,:)=[0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1];
MASK(4,:)=[1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0];
% MASK es la mascara que asocia a cada BTS a uno de 4 grupos de frecuencias
% MASK(g,b)=1 si la BTS b-esima pertenece al grupo de frecuencias g-esimo


% El siguiente lazo multiple calcula el C/I en cada punto de la rejilla
for x=1:260
    for y=1:290
        pos=x+j*y; % pos es la posicion (compleja) del punto (x,y) 
        for b=1:20
            d=50*abs(pos-BTS(b)); % distancia en metros del punto x,y a la celda b-esima
            Pr(b)=Pref-10*n*log10(d/dref)+sigma*SHAD(x,y,b)/100; % modelo exponencial
        end
        [C,I]=max(Pr); % determinar la celda dominante en el punto x,y
        C=10^(C/10); Celda(x,y)=I;
        FCelda=1*MASK(1,I)+2*MASK(2,I)+3*MASK(3,I)+4*MASK(4,I); % determinar a que grupo de frec pertenece la celda dominante
        Int=sum(10.^(Pr/10).*MASK(FCelda,:))-C;
        CI(x,y)=10*log10(C/Int); % calcular el C/I en dB del punto x,y
    end
end

% obtencion del vector CIV (valores de C/I(dB) de los puntos de la rejilla ordenados)
for x=1:260; for y=1:290; CIV((x-1)*290+y)=CI(x,y); end; end
CIV=sort(CIV); 


%PERCENTILES
disp(' el 90% de los puntos experimentan un C/I (dB) de al menos')
disp(0.1*round(10*CIV(round(.1*length(CIV)))))

disp(' el 95% de los puntos experimentan un C/I (dB) de al menos')
disp(0.1*round(10*CIV(round(.05*length(CIV)))))

disp(' el 99% de los puntos experimentan un C/I (dB) de al menos')
disp(0.1*round(10*CIV(round(.01*length(CIV)))))


% Grafica de celdas dominantes
% un color distinto para cada grupo de frecuencias
K=input('Grafica de celdas dominantes en cada punto? (S/N)','s');

if K=='S' || K=='s'
disp('Graficando...');
newplot; plot(260,290,'k.'); hold on

for x=1:260
    for y=1:290
        if MASK(1,Celda(x,y))==1; COLOR='b'; end
        if MASK(2,Celda(x,y))==1; COLOR='r'; end
        if MASK(3,Celda(x,y))==1; COLOR='g'; end
        if MASK(4,Celda(x,y))==1; COLOR='y'; end
        punto=strcat(COLOR,'.');
        plot(x,y, punto)
    end
end
for b=1:20; plot(real(BTS(b)), imag(BTS(b)),'kx'); end
hold off
else
end

umbral=input('Umbral de indisponibilidad (C/I minimo requerido en dB)?');

kk=1; while CIV(kk)<umbral; kk=kk+1; end

% Calculo del % de indisponibilidad
disp('Indisponibilidad del sistema (%):')
disp(round(1000*kk/length(CIV))/10)

% Grafica de puntos fuera de cobertura
R=input('Grafica de puntos fuera de cobertura? (S/N)','s');

if R=='S' || R=='s'
    disp('Graficando...');
    hold on;
        if K ~= 's' & K ~= 'S'; hold off; newplot; plot(260,290,'k.'); hold on; end 
    for b=1:20; plot(real(BTS(b)), imag(BTS(b)),'kx'); end
    for x=1:260
        for y=1:290
            if CI(x,y)<umbral; plot(x,y, 'k.'); end
        end
    end
    hold off
else
end