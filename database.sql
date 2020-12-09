CREATE TABLE tb_user(
       id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
       nome VARCHAR(255),
       sobrenome VARCHAR(255),
       email VARCHAR(100),
       senha VARCHAR(50));

CREATE TABLE tb_languagem(
       id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
       languagem VARCHAR(255),
       sig VARCHAR(12),
       char_def VARCHAR(50));

CREATE TABLE tb_user_to_languagem(
       id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
       id_user INTEGER NOT NULL,
       id_lang INTEGER NOT NULL,
       FOREIGN KEY (id_user) REFERENCES tb_user(id)
       ON DELETE CASCADE ON UPDATE NO ACTION,
       FOREIGN KEY (id_lang) REFERENCES tb_languagem(id)
       ON DELETE CASCADE ON UPDATE NO ACTION);

CREATE TABLE tb_word(
       id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
       word VARCHAR(255),
       id_lang INTEGER NOT NULL,
       id_img INTEGER NOT NULL,
       origem_text TEXT,
       FOREIGN KEY (id_lang) REFERENCES tb_languagem(id)
       ON DELETE CASCADE ON UPDATE NO ACTION,
       FOREIGN KEY (id_img) REFERENCES tb_image(id)
       ON DELETE CASCADE ON UPDATE NO ACTION);

CREATE TABLE tb_imagem(
       id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
       imagem BLOB);


CREATE TABLE tb_equal_lang_word(
       id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
       id_word INTEGER NOT NULL,
       id_lang INTEGER NOT NULL);
 
