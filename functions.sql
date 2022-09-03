create or replace PROCEDURE info_videos_to_json

IS
    cursor c is SELECT video_id,title,description,duree,annee,multilang,formato,disponibilite
        FROM Videos ;  -- declaration du pointeur

        c_rec c%rowtype;
BEGIN

open c; -- ouvrir le pointeur

LOOP
    fetch c
        INTO c_rec;  --fetching of data
    EXIT WHEN c%NOTFOUND ;
    DBMS_OUTPUT.PUT_LINE ('ID: '|| c_rec.video_id);
    DBMS_OUTPUT.PUT_LINE('Titre: '|| c_rec.title);
    DBMS_OUTPUT.PUT_LINE('Info: '|| c_rec.description);
    DBMS_OUTPUT.PUT_LINE('Duree: '|| c_rec.duree);
    DBMS_OUTPUT.PUT_LINE('Annee: '|| c_rec.annee);
    DBMS_OUTPUT.PUT_LINE('Multilang: '|| c_rec.multilang);
    DBMS_OUTPUT.PUT_LINE('Format: '|| c_rec.formato);
    DBMS_OUTPUT.PUT_LINE('Disponibilite: '|| c_rec.disponibilite);
END LOOP ;
    close c;
END info_videos_to_json;
/


execute info_videos_to_json();

DECLARE
message Varchar;
BEGIN
message :=  info1_videos_to_json;
    DBMS_OUTPUT.PUT_LINE (message);
END;



-- FUNCTION
create or replace FUNCTION info_videos_to_json
      return varchar2

IS

    json VARCHAR2(4000);

BEGIN

json := '[';

for c_rec in ( SELECT video_id,title,description
              FROM Videos )  -- declaration du pointeur

LOOP

    json:= json ||  '{"ID" : "'|| c_rec.video_id || '",';
    json := json || '"Titre":" '|| c_rec.title || '",';
    json := json  ||'"Info":" '|| c_rec.description || '"}, ';
  /*  DBMS_OUTPUT.PUT_LINE('Duree: '|| c_rec.duree);
    DBMS_OUTPUT.PUT_LINE('Annee: '|| c_rec.annee);
    DBMS_OUTPUT.PUT_LINE('Multilang: '|| c_rec.multilang);
    DBMS_OUTPUT.PUT_LINE('Format: '|| c_rec.formato);
    DBMS_OUTPUT.PUT_LINE('Disponibilite: '|| c_rec.disponibilite);*/
END LOOP ;
json := json || ']';

    RETURN json;
END info_videos_to_json;

SELECT info_videos_to_json as INFO FROM VIDEOS;
