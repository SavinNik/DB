import psycopg2


def create_db(conn):
    with conn.cursor() as cur:
        cur.execute("""
        CREATE TABLE IF NOT EXISTS clients(
            id SERIAL PRIMARY KEY,
            first_name VARCHAR (20),
            last_name VARCHAR (20),
            email VARCHAR (40) UNIQUE
            );
        CREATE TABLE IF NOT EXISTS phones(
            id SERIAL PRIMARY KEY,
            client_id INTEGER REFERENCES clients(id),
            phone VARCHAR(20)
        );    
        """)
        conn.commit()


def add_client(conn, first_name, last_name, email, phone=None):
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO clients(
            first_name, last_name, email)
            VALUES(%s, %s, %s)
            RETURNING id;
            """, (first_name, last_name, email))
        client_id = cur.fetchone()
        cur.execute("""
            INSERT INTO phones(client_id, phone)
            VALUES(%s, %s);
            """, (client_id, phone))
        cur.execute("""
            SELECT * FROM phones;
            """)
        print(cur.fetchall())


def add_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute("""
           INSERT INTO phones(client_id, phone)
            VALUES(%s,%s);
            """, (client_id, phone))
        cur.execute("""
            SELECT * FROM phones;
            """)
        print(cur.fetchall())


def change_client(conn, client_id, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        if first_name is not None:
            cur.execute("""
                UPDATE clients
                SET first_name = %s
                WHERE id = %s;
                """, (first_name, client_id))
        if last_name is not None:
            cur.execute("""
                UPDATE clients
                SET last_name = %s
                WHERE id = %s;
                """, (last_name, client_id))
        if email is not None:
            cur.execute("""
                UPDATE clients
                SET email = %s
                WHERE id = %s;
                """, (email, client_id))
        if phone is not None:
            cur.execute("""
                UPDATE phones
                SET phone = %s
                WHERE client_id = %s AND id =(
                    SELECT min(id)
                    FROM phones
                    WHERE client_id = %s)
                """, (phone, client_id, client_id))
        cur.execute("""
            SELECT * FROM clients;
            """)
        print(cur.fetchall())
        cur.execute("""
            SELECT * FROM phones;
            """)
        print(cur.fetchall())


def delete_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute("""
            DELETE FROM phones
            WHERE phone = %s AND client_id = %s;
            """, (phone, client_id))
        cur.execute("""
            SELECT * FROM phones;
            """)
        print(cur.fetchall())


def delete_client(conn, client_id):
    with conn.cursor() as cur:
        cur.execute("""
            DELETE FROM phones
            WHERE client_id = %s;
            """, (client_id,))
        cur.execute("""
            DELETE FROM clients
            WHERE id = %s;
            """, (client_id,))
        cur.execute("""
            SELECT * FROM clients;
            """)
        print(cur.fetchall())


def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        if phone is not None:
            cur.execute("""
                SELECT c.id, c.first_name, c.last_name, c.email
                FROM phones ph
                LEFT JOIN clients c ON ph.client_id = c.id
                WHERE ph.phone = %s
                """, (phone,))
            print(cur.fetchall())
        elif email is not None:
            cur.execute("""
                SELECT * 
                FROM clients
                WHERE email = %s;
                """, (email,))
            print(cur.fetchall())
        elif first_name is not None:
            cur.execute("""
                SELECT * 
                FROM clients
                WHERE first_name = %s;
                """, (first_name,))
            print(cur.fetchall())
        elif last_name is not None:
            cur.execute("""
                SELECT * 
                FROM clients
                WHERE last_name = %s;
                """, (last_name,))
            print(cur.fetchall())


with psycopg2.connect(database="Clients", user="postgres", password="rNmq2TMS") as conn:
    # create_db(conn)
    # add_client(conn, 'Ivan', 'Ivanov', 'ivan@mail.ru', '79991111111')
    # add_client(conn, 'Petr', 'Petrov', 'petr@mail.ru', '79192222222')
    # add_client(conn, 'Roman', 'Romanov', 'roman@gmail.com')
    # add_phone(conn, 1, '79993333333')
    # add_phone(conn, 3, '79794444444')
    # change_client(conn, 2, first_name='Artem', phone=79991234569)
    # delete_phone(conn, 1, '79993333333')
    # delete_client(conn, 1)
    # find_client(conn, phone='79794444444')
    # find_client(conn, email='petr@mail.ru')
    # find_client(conn, first_name='Artem')
    find_client(conn, last_name='Romanov')
conn.close()
