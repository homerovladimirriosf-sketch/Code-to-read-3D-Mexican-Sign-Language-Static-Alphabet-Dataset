using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Media3D;
using HelixToolkit.Wpf; 

namespace KinectApp
{
    public partial class MainWindow : Window
    {
               private HelixViewport3D viewPort;
        private PointsVisual3D puntosVisuales;

        public MainWindow()
        {
            InitializeComponent();

            // Inicializa el visor 3D
            InicializarVisor();

            // Carga los datos Colocar toda la ruta del archivo
            string rutaArchivo = "C:\\Users\\pccom\\OneDrive\\Desktop\\a1.txt";

            if (File.Exists(rutaArchivo))
            {
                CargarPuntosDesdeArchivo(rutaArchivo);
            }
            else
            {
                MessageBox.Show("No se encontró el archivo a1.txt en la carpeta del ejecutable.");
            }
        }

        private void InicializarVisor()
        {
            // Crear el Viewport (el motor 3D)
            viewPort = new HelixViewport3D();
            viewPort.ZoomExtentsWhenLoaded = true;
            viewPort.ShowCoordinateSystem = true;
            viewPort.Background = Brushes.Black; // Fondo negro para que resalten los puntos

            // Añadir luces
            viewPort.Children.Add(new SunLight());

            // Crear el contenedor de puntos
            puntosVisuales = new PointsVisual3D();
            puntosVisuales.Color = Colors.LimeGreen; // Color verde 
            puntosVisuales.Size = 2; // Tamaño del punto

            // Añadir los puntos al visor
            viewPort.Children.Add(puntosVisuales);

            // Meter el visor dentro del Grid de la interfaz
            MainGrid.Children.Add(viewPort);
        }

        private void CargarPuntosDesdeArchivo(string ruta)
        {
            try
            {
                Point3DCollection puntos = new Point3DCollection();

                // Leer todas las líneas del archivo
                string[] lineas = File.ReadAllLines(ruta);

                foreach (string linea in lineas)
                {
                    if (string.IsNullOrWhiteSpace(linea)) continue;

                    // Separar por espacios
                    string[] partes = linea.Split(new[] { ' ', '\t' }, StringSplitOptions.RemoveEmptyEntries);

                    if (partes.Length >= 3)
                    {
                        
                        if (double.TryParse(partes[0], System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out double x) &&
                            double.TryParse(partes[1], System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out double y) &&
                            double.TryParse(partes[2], System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out double z))
                        {
                            puntos.Add(new Point3D(x, y, z));
                        }
                    }
                }

                // Asignar la colección de puntos al objeto visual
                puntosVisuales.Points = puntos;

                // Ajustar la cámara automáticamente para ver todos los puntos
                viewPort.ZoomExtents();

                this.Title = $"Visor Kinect - {puntos.Count} puntos cargados";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al procesar el archivo: " + ex.Message);
            }
        }
    }
}