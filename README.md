# Muelle-Amortiguado

iOS App que permite estudiar el movimiento oscilatorio de un cuerpo de masa m unido a un muelle.

# Descripción

La aplicación mostrará tres gráficas:

Posición del cuerpo en función del tiempo: la posición en el eje vertical y el tiempo en el eje horizontal.

Velocidad del cuerpo en función del tiempo: la velocidad en el eje vertical y el tiempo en el eje horizontal.

Relación velocidad-posicion: La velocidad en el eje vertical y la posición en el horizontal.

La aplicación permitirá estudiar cómo es el movimiento del cuerpo seguún se varia el valor de los sliders, repintando en tiempo real las tres gráficas pedidas.

La aplicación tendrá tres sliders para variar los siguientes valores:

- La masa del cuerpo.
- La constante del muelle.
- La constante de rozamiento.

# Modificaciones

Incluye reconocedores de gestos:

- Gesto “Pinch” en las tres views para cambiar los valores de la escala en X e Y.

- Gesto “Tap” en “SpeedAndPositionView”, de forma que cada vez que se toca dicha view, se cambia el intervalo de tiempo representado (se necesitan varios toques para apreciarlo).

- Gesto “LongPress” en la View “PositionView”, de forma que cada vez que se toca dicha view se cambia el color del fondo de ésta.

- Gesto “Pan” en la View “speedAndPositionView”, de forma que se puede mover por la pantalla dicha view.

### Documentación http://www.sc.ehu.es/sbweb/fisica/oscilaciones/amortiguadas/amortiguadas.htm