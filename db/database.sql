CREATE TABLE tb_user(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       username VARCHAR(255),
       nome VARCHAR(255),
       sobrenome VARCHAR(255),
       email VARCHAR(100),
       password VARCHAR(50));

CREATE TABLE tb_languagem(
       languagem_id INTEGER PRIMARY KEY AUTOINCREMENT,
       languagem VARCHAR(255),
       sig VARCHAR(12),
       char_def VARCHAR(50));

CREATE TABLE tb_user_to_languagem(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       id_user INTEGER NOT NULL,
       id_lang INTEGER NOT NULL,
       FOREIGN KEY (id_user) REFERENCES tb_user(id)
       ON DELETE CASCADE ON UPDATE NO ACTION,
       FOREIGN KEY (id_lang) REFERENCES tb_languagem(id)
       ON DELETE CASCADE ON UPDATE NO ACTION);

CREATE TABLE tb_word(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       word VARCHAR(255),
       id_lang INTEGER NOT NULL,
       id_img INTEGER NOT NULL,
       origem_text TEXT,
       FOREIGN KEY (id_lang) REFERENCES tb_languagem(id)
       ON DELETE CASCADE ON UPDATE NO ACTION,
       FOREIGN KEY (id_img) REFERENCES tb_image(id)
       ON DELETE CASCADE ON UPDATE NO ACTION);

CREATE TABLE tb_imagem(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       imagem BLOB);


CREATE TABLE tb_equal_lang_word(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       id_word INTEGER NOT NULL,
       id_lang INTEGER NOT NULL);
 
