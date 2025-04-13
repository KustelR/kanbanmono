
CREATE TABLE PROJECTS (
    id varchar(30) NOT NULL,
    name varchar(20) NOT NULL,
    created_by VARCHAR(30) NOT NULL,
    updated_by VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE Columns (
    id VARCHAR(30) NOT NULL,
    project_id VARCHAR(30) NOT NULL,
    name varchar(20) NOT NULL,
    draw_order INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES Projects (id) ON DELETE CASCADE
);
CREATE TABLE Cards (
    id VARCHAR(30) not null,
    column_id VARCHAR(30) not null,
    name VARCHAR(20) not null,
    description TEXT not null,
    draw_order INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (column_id) REFERENCES Columns (id) ON DELETE CASCADE
);
CREATE TABLE Tags (
    id VARCHAR(30) not null,
    project_id VARCHAR(30) not null,
    name VARCHAR(20) not null,
    color VARCHAR(7) not null,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES Projects (id) ON DELETE CASCADE
);
CREATE TABLE CardsTags (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    card_id VARCHAR(30) NOT NULL,
    tag_id VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (card_id) REFERENCES Cards (id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES Tags (id) ON DELETE CASCADE
);



DELIMITER $$


CREATE PROCEDURE add_card(
    p_column_id CHAR(30), 
    p_id CHAR(30), 
    p_name CHAR(20), 
    p_description TEXT, 
    p_draw_order INT)
BEGIN
    INSERT Cards (
        id,
        column_id,
        name,
        description,
        draw_order
    ) VALUES (
        p_id,
        p_column_id,
        p_name,
        p_description,
        p_draw_order
    ) ON DUPLICATE KEY UPDATE
        column_id = p_column_id,
        name = p_name,
        description = p_description,
        draw_order = p_draw_order;
 END$$

 DELIMITER ;


DELIMITER $$


CREATE PROCEDURE add_column(
    p_project_id char(30), 
    p_id char(30), 
    p_name char(20), 
    p_draw_order INT)
BEGIN
    INSERT Columns (
        id,
        project_id,
        name,
        draw_order
    ) VALUES (
        p_id, 
        p_project_id, 
        p_name, 
        p_draw_order
    ) ON DUPLICATE KEY UPDATE 
        id=p_id, 
        project_id=p_project_id, 
        name=p_name, 
        draw_order=p_draw_order;
END$$

DELIMITER ;


DELIMITER $$


CREATE PROCEDURE pop_card_reorder(
    p_column_id CHAR(30), 
    p_popped_order INT)
BEGIN
    UPDATE Cards 
    SET 
    draw_order = draw_order - 1
    WHERE draw_order > p_popped_order AND column_id = p_column_id;
END$$

DELIMITER ;


DELIMITER $$


CREATE PROCEDURE pop_column_reorder(
    p_project_id CHAR(30), 
    p_popped_order INT)
BEGIN
    UPDATE Columns 
    SET 
    draw_order = draw_order - 1
    WHERE draw_order > p_popped_order AND project_id = p_project_id;
END$$

DELIMITER ;


DELIMITER $$


CREATE PROCEDURE update_card(
    p_id CHAR(30), 
    p_column_id CHAR(30), 
    p_name CHAR(20), 
    p_description TEXT, 
    p_draw_order INT)
BEGIN
    UPDATE Cards 
    SET 
    name = p_name,
    description = p_description,
    draw_order = p_draw_order,
    column_id = p_column_id
    WHERE id = p_id;
END$$

DELIMITER ;



DELIMITER $$


CREATE PROCEDURE update_column_data(
    p_id CHAR(30), 
    p_name CHAR(20), 
    p_draw_order INT)
BEGIN
    UPDATE Columns 
    SET 
    name = p_name,
    draw_order = p_draw_order
    WHERE id = p_id;
END$$

DELIMITER ;



DELIMITER $$


CREATE PROCEDURE update_project_data(
    p_id CHAR(30), 
    p_name CHAR(20))
BEGIN
    UPDATE Projects 
    SET 
    name = p_name
    WHERE id = p_id;
END$$

DELIMITER ;