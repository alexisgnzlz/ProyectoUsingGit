# ProyectoUsingGit
This is a project of a cellular network for a course called movile systems at Simon Bolivar University

EC3443/EC4432/EC6432 COMUNICACIONES MOVILES – Prof. Renny E. Badra
Abril / Julio 2017 - PROYECTO DE SIMULACION I (15%)

Herramienta

Se usará MATLAB (versión básica). Se dispondrá de un programa de simulación predefinido
(ESCEL) y la data que lo apoya. Dicho código deberá ser modificado por cada grupo de
estudiantes con el fin de lograr los objetivos previstos.
Entorno de Simulación CELular (ESCEL)
La versión básica proporcionada emplea el modelo de propagacion exponencial para estimar
el C/I (enlace de bajada) en cada punto de una rejilla de 50m x 50m sobre un area a cubrir de
13 km x 14.5 km (una ciudad mediana), con un total de veinte (20) celdas de radio nominal
de 1.5 km cada una, y asumiendo un factor de reuso N=4 y antenas omnidireccionales. El
programa está profusamente comentado a fin de facilitar su alteración.
La data que apoya el programa está contenida en un archivo previamente generado. Cada
grupo de trabajo recibe un juego de datos distinto pero estadísticamente equivalente a los
demás. El archivo proporcionado contiene los arreglos BTS y SHAD, los cuales no deben ser
alterados. El archivo correspondiente a cada grupo de trabajo estará disponible en sus
Casilleros de Aula Virtual.
El arreglo BTS es un vector de tamaño 20 cuyos elemento b-ésimo BTS(b) son las
coordenadas (complejas) de la BTS b-ésima, es decir, BTS(b) = x + j*y. Las posiciones de
las celdas se corresponden a las de una rejilla hexagonal con una variabilidad aleatoria del
+/- 10% del radio en cada coordenada. BTS es un arreglo del tipo doble precisión.
El arreglo SHAD es una matriz 3D de valores de ensombrecimiento (normalizados) en dB.
Los valores de SHAD son enteros y están escalados por un factor de 100. Los valores de
SHAD poseen correlacion espacial y angular de acuerdo a modelos aceptados en la literatura
especializada.

Informe

El informe debe contener el código utilizado para simular cada uno de los escenarios
propuestos (excepto el escenario 1), así como los resultados obtenidos y su análisis
detallado, explicando discrepancias entre los resultados teóricos y los experimentales. Se
dará igual peso a los resultados obtenidos (y el proceso que conduce a ellos) como a su
análisis. El código de cada grupo debe ser original (no se aceptarán códigos compartidos
entre grupos).
El informe se entregará sólo en versión electrónica PDF, la cual se debe subir al Casillero de
Aula Virtual antes de la fecha indicada. La extensión máxima del informe es de 25 páginas
(incluyendo todo).Escenarios a simular

1. (3p) Antenas Omni, reuso N=4. Contrastar la estimación teórica del C/I mínimo
garantizado con los distintos percentiles de C/I que proporciona el programa. Repetir
la experiencia para los siguientes valores del coeficiente de propagación: 3, 3.5, 4, 4.5,
5. Analizar igualmente el porcentaje de ubicaciones indisponibles (indisponibilidad)
para un requerimiento de C/I de 12 dB. Concluir en base a los resultados obtenidos.

2. (3p) Antenas Omni, reuso N=4, modelo de Hata. Sustituir el modelo de propagación
exponencial por el de Hata, usando un EIRP de 25 watt. (a) Utilizar alturas de antenas
iguales en todas las celdas (32 metros) con portadoras de 850 MHz, y contrastar los
distintos percentiles de C/I con los obtenidos en el escenario I. (b) Repetir el
experimento (a) con portadoras de 1900 MHz (modelo COST 231) y comparar la las
gráficas de cobertura, con las de 850 MHz. (c) Volviendo al escenario de 850 MHz,
aumentar sólo la altura de la torre de la celdas números 7 y 17 hasta 48 metros, y
comparar las gráficas de cobertura con las obtenidas en (a). Concluir en cada caso.

3. (3p) Antenas Sectorizadas, reuso N=4/12. Partiendo del código original (modelo de
propagación exponencial), introducir alteraciones de forma de imponer un reuso 4/12
con antenas secorizadas ideales de 120 ° . Repetir las experiencias del escenario I y
comparar los resultados de ambas. Luego calcular el impacto de la sectorización
propuesta en términos de número de suscriptores que pueden atenderse con un GoS
de 2% sobre todo el sistema (para ello, asumir que se cuenta con un total de 60
portadoras GSM y que la carga promedio ofrecida por cada suscriptor en la hora pico
es 30 mE). Concluir en base a estos resultados. Nota: en este escenario es necesario
definir doce (12) grupos de frecuencias, en lugar de los cuatro (4) definidos en el
código original. Cada punto (x,y) de la rejilla debe asociarse no a una celda dominante
(como está en el código original), sino a una pareja celda/sector dominante. A fin de
determinar la pareja celda/sector dominante y las fuentes de interferencia sobre cada
punto de la rejilla, es necesario obtener el ángulo entre cada punto (x,y) y la BTS
respectiva (para ello se sugiere utilizar el comando MATLAB angle(pos-BTS)) y
luego determinar cual de los tres sectores de la respectiva BTS cubre el punto (x,y).

4. (3p) Problema de Asignación de Frecuencias, antenas omni, reuso N=5 y N=6.
Partiendo del código original (modelo exponencial con n=3.3), con antenas omni, se
pide proponer asignaciones de frecuencias sobre todo el sistema basado en N=5 y
N=6 grupos de frecuencias que minimice la indisponibilidad global. Nota: Se sugiere ir
probando distintos esquemas de asignación de frecuencias de forma iterativa (ensayo
y error). La asignación puede obtenerse de cualquier forma (empíricamente,
aleatoriamente, usando algoritmos de optimización, etc). El grupo que obtenga la
menor indisponibilidad en cada caso recibirá 2p de crédito extra.

5. (3p) Compromiso capacidad - cobertura, antenas omni, reuso variable. En este
experimento se requiere plantear una asignación frecuencial para cada uno de los
siguientes valores del factor de reuso: N = 3, 4, 5 y 6, y se obtendrá la indisponibilidad
global para n=3.3. La asignación para N=3 y N=4 responde al esquema regular
estándar. Los resultados de indisponibilidad para N=5 y N=6 son los obtenidos en la
experiencia 4. Además, se calculará la capacidad obtenida para cada valor de N en
términos de número de suscriptores que pueden atenderse con un GoS de 2% sobre
todo el sistema (mismas condiciones que en la experiencia 3). Finalmente se graficará
capacidad y confiabilidad (100-indisponibilidad_%) vs. N y se concluirá al respecto.
