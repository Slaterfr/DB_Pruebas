import sqlite3 as sql
import os

DB_NAME = "ElectroTechDB.db"
STRUCTURE_FILE = 'ElectroTech.sql'
TEST_FILE = 'pruebas.sql'

def create_db_structure():
    """Conecta, activa FK y ejecuta el script de creación de tablas."""
    conn = None
    try:
        conn = sql.connect(DB_NAME)
        cursor = conn.cursor()
        
        # 1. Activación de Claves Foráneas de forma separada (para evitar el bug)
        cursor.execute("PRAGMA foreign_keys = ON;")
        
        # 2. Ejecución del script de creación de tablas
        with open(STRUCTURE_FILE, 'r', encoding='utf-8') as f:
            sql_script = f.read()
            
        cursor.executescript(sql_script)
        conn.commit()
        print("---")
        print(f"✅ Base de datos y tablas creadas exitosamente en '{DB_NAME}'.")
        
    except sql.Error as e:
        print(f"❌ Ocurrió un error al crear la estructura: {e}")
        # Si la DB ya existía, el error puede ser solo un mensaje.
    except FileNotFoundError:
        print(f"❌ Error: No se encontró el archivo SQL de estructura: '{STRUCTURE_FILE}'.")
    finally:
        if conn:
            conn.close()

def run_test_queries():
    """Conecta, lee el script de pruebas, ejecuta las consultas y muestra los resultados."""
    conn = None
    try:
        conn = sql.connect(DB_NAME)
        cursor = conn.cursor()
        cursor.execute("PRAGMA foreign_keys = ON;") # Asegurar FK para pruebas de integridad
        
        print("\n--- INICIO DE PRUEBAS Y OBTENCIÓN DE EVIDENCIA ---")
        
        # 1. Leer el archivo de pruebas
        with open(TEST_FILE, 'r', encoding='utf-8') as f:
            # Dividimos el script por punto y coma (;) para ejecutar sentencia por sentencia
            sql_commands = f.read().split(';')

        # 2. Ejecutar cada comando individualmente
        for command in sql_commands:
            command = command.strip()
            if not command:
                continue

            print(f"\n▶️ Ejecutando: {command.splitlines()[0]}...")
            
            try:
                cursor.execute(command)
                
                # Si es un SELECT, obtenemos los resultados y los mostramos
                if command.strip().upper().startswith("SELECT"):
                    results = cursor.fetchall()
                    
                    # Obtener los nombres de las columnas para un encabezado claro
                    column_names = [description[0] for description in cursor.description]
                    
                    print("\n[RESULTADO OBTENIDO - EVIDENCIA]")
                    print("---")
                    print(" | ".join(column_names))
                    print("-" * (sum(len(c) for c in column_names) + len(column_names) * 3))
                    for row in results:
                        print(" | ".join(map(str, row)))
                    print("---\n")
                
                # Si es un DML (INSERT, DELETE, UPDATE) exitoso
                elif command.strip().upper().startswith(("INSERT", "DELETE", "UPDATE")):
                    conn.commit()
                    print("✅ Comando ejecutado exitosamente. Cambios guardados.")
                    
            except sql.Error as e:
                # Este es el resultado esperado para las pruebas de integridad (Proyecto I)
                print(f"❌ ERROR (EVIDENCIA DE INTEGRIDAD): {e}")

    except FileNotFoundError:
        print(f"❌ Error: No se encontró el archivo de pruebas: '{TEST_FILE}'.")
    except Exception as e:
        print(f"❌ Ocurrió un error inesperado durante las pruebas: {e}")
    finally:
        if conn:
            conn.close()
        print("\n--- FIN DE PRUEBAS ---")

if __name__ == "__main__":
    # 1. Crear la estructura (Tarea I)
    create_db_structure()
    
    # 2. Ejecutar y mostrar las pruebas (Tarea II y Proyecto I)
    if os.path.exists(DB_NAME):
        run_test_queries()