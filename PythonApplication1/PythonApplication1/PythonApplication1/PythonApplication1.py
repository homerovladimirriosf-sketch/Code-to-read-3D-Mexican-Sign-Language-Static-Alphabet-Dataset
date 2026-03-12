import open3d as o3d
import numpy as np
import os

def cargar_y_visualizar_kinect(ruta_archivo):
    
    if not os.path.exists(ruta_archivo):
        print(f"Error: No se encuentra el archivo en {ruta_archivo}")
        return

    print("Cargando nube de puntos...")
    
    try:
        # Leer los datos usando numpy
        # El archivo tiene formato X Y Z separados por espacios
        puntos = np.loadtxt(ruta_archivo)

        # Crea el objeto de nube de puntos de Open3D
        pcd = o3d.geometry.PointCloud()
        
        # Convierte los datos a formato vectorial 3D
        pcd.points = o3d.utility.Vector3dVector(puntos)

        # Estima normales (ayuda a la visualización)
        pcd.estimate_normals()

        # Pinta la nube 
        # Los colores en Open3D van de 0 a 1 [R, G, B]
        pcd.paint_uniform_color([0.2, 0.8, 0.2]) 

        print(f"Puntos cargados: {len(puntos)}")
        print("Cerrar la ventana para finalizar.")

        # Crea la ventana de visualización
        o3d.visualization.draw_geometries([pcd], 
                                          window_name="Visor Kinect v1 - Python",
                                          width=800, 
                                          height=600,
                                          left=50, 
                                          top=50)

    except Exception as e:
        print(f"Ocurrió un error al procesar los datos: {e}")

if __name__ == "__main__":
    # Colocar la ruta dondese encuentra el archivo
    cargar_y_visualizar_kinect(r"C:\Users\pccom\OneDrive\Desktop\a1.txt")
