"""Gestion des "routes" FLASK et des données pour les genres.
Fichier : gestion_genres_crud.py
Auteur : OM 2021.03.16
"""
from pathlib import Path

from flask import redirect
from flask import request
from flask import session
from flask import url_for

from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFAjouterGenres
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFDeleteGenre
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFUpdateGenre
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFAttribuerObjet
"""
    Auteur : OM 2021.03.16
    Définition d'une "route" /genres_afficher
    
    Test : ex : http://127.0.0.1:5575/genres_afficher
    
    Paramètres : order_by : ASC : Ascendant, DESC : Descendant
                id_genre_sel = 0 >> tous les genres.
                id_genre_sel = "n" affiche le genre dont l'id est "n"
"""


@app.route("/genres_afficher/<string:order_by>/<int:id_genre_sel>", methods=['GET', 'POST'])
def genres_afficher(order_by, id_genre_sel):
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                if order_by == "ASC" and id_genre_sel == 0:
                    strsql_genres_afficher = """SELECT id_objets, nom_objets, etat_objets FROM t_objets ORDER BY id_objets ASC"""
                    mc_afficher.execute(strsql_genres_afficher)
                elif order_by == "ASC":
                    # C'EST LA QUE VOUS ALLEZ DEVOIR PLACER VOTRE PROPRE LOGIQUE MySql
                    # la commande MySql classique est "SELECT * FROM t_genre"
                    # Pour "lever"(raise) une erreur s'il y a des erreurs sur les noms d'attributs dans la table
                    # donc, je précise les champs à afficher
                    # Constitution d'un dictionnaire pour associer l'id du genre sélectionné avec un nom de variable
                    valeur_id_genre_selected_dictionnaire = {"value_id_genre_selected": id_genre_sel}
                    strsql_genres_afficher = """SELECT id_objets, nom_objets, etat_objets FROM t_objets WHERE id_objets = %(value_id_genre_selected)s"""

                    mc_afficher.execute(strsql_genres_afficher, valeur_id_genre_selected_dictionnaire)
                else:
                    strsql_genres_afficher = """SELECT id_objets, nom_objets, etat_objets  FROM t_objets ORDER BY id_objets DESC"""

                    mc_afficher.execute(strsql_genres_afficher)

                data_genres = mc_afficher.fetchall()

                print("data_genres ", data_genres, " Type : ", type(data_genres))

                # Différencier les messages si la table est vide.
                if not data_genres and id_genre_sel == 0:
                    flash("""La table "t_genre" est vide. !!""", "warning")
                elif not data_genres and id_genre_sel > 0:
                    # Si l'utilisateur change l'id_genre dans l'URL et que le genre n'existe pas,
                    flash(f"Le genre demandé n'existe pas !!", "warning")


        except Exception as Exception_genres_afficher:
            raise ExceptionGenresAfficher(f"fichier : {Path(__file__).name}  ;  "
                                          f"{genres_afficher.__name__} ; "
                                          f"{Exception_genres_afficher}")

    # Envoie la page "HTML" au serveur.
    return render_template("genres/genres_afficher.html", data=data_genres)


"""
    Auteur : OM 2021.03.22
    Définition d'une "route" /genres_ajouter
    
    Test : ex : http://127.0.0.1:5575/genres_ajouter
    
    Paramètres : sans
    
    But : Ajouter un genre pour un film
    
    Remarque :  Dans le champ "name_genre_html" du formulaire "genres/genres_ajouter.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/genres_ajouter", methods=['GET', 'POST'])
def genres_ajouter_wtf():
    form = FormWTFAjouterGenres()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                name_genre_wtf = form.nom_genre_wtf.data
                name_genre = name_genre_wtf.lower()
                valeurs_insertion_dictionnaire = {"value_intitule_genre": name_genre}
                print("valeurs_insertion_dictionnaire ", valeurs_insertion_dictionnaire)

                strsql_insert_genre = """INSERT INTO t_objets (id_objets,nom_objets) VALUES (NULL,%(value_intitule_genre)s) """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_genre, valeurs_insertion_dictionnaire)

                flash(f"Données insérées !!", "success")
                print(f"Données insérées !!")

                # Pour afficher et constater l'insertion de la valeur, on affiche en ordre inverse. (DESC)
                return redirect(url_for('genres_afficher', order_by='DESC', id_genre_sel=0))

        except Exception as Exception_genres_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  "
                                            f"{genres_ajouter_wtf.__name__} ; "
                                            f"{Exception_genres_ajouter_wtf}")

    return render_template("genres/genres_ajouter_wtf.html", form=form)


"""
    Auteur : OM 2021.03.29
    Définition d'une "route" /genre_update
    
    Test : ex cliquer sur le menu "genres" puis cliquer sur le bouton "EDIT" d'un "genre"
    
    Paramètres : sans
    
    But : Editer(update) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"
    
    Remarque :  Dans le champ "nom_genre_update_wtf" du formulaire "genres/genre_update_wtf.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/genre_update", methods=['GET', 'POST'])
def genre_update_wtf():
    # L'utilisateur vient de cliquer sur le bouton "EDIT". Récupère la valeur de "id_genre"
    id_genre_update = request.values['id_genre_btn_edit_html']

    # Objet formulaire pour l'UPDATE
    form_update = FormWTFUpdateGenre()
    try:
        # 2023.05.14 OM S'il y a des listes déroulantes dans le formulaire
        # La validation pose quelques problèmes

        if form_update.submit_btn_annuler.data:
            return redirect(url_for("genres_afficher", order_by="ASC", id_genre_sel=0))


        if request.method == "POST" and form_update.submit.data:
            # Récupèrer la valeur du champ depuis "genre_update_wtf.html" après avoir cliqué sur "SUBMIT".
            # Puis la convertir en lettres minuscules.
            name_genre_update = form_update.nom_genre_update_wtf.data
            name_genre_update = name_genre_update.lower()
            date_genre_essai = form_update.date_genre_wtf_essai.data

            valeur_update_dictionnaire = {"value_id_genre": id_genre_update,
                                          "value_name_genre": name_genre_update,
                                          "value_date_genre_essai": date_genre_essai
                                          }
            print("valeur_update_dictionnaire ", valeur_update_dictionnaire)

            str_sql_update_intitulegenre = """UPDATE t_objets SET nom_objets = %(value_name_genre)s, 
            etat_objets = %(value_date_genre_essai)s WHERE id_objets = %(value_id_genre)s """
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_update_intitulegenre, valeur_update_dictionnaire)

            flash(f"Donnée mise à jour !!", "success")
            print(f"Donnée mise à jour !!")

            # afficher et constater que la donnée est mise à jour.
            # Affiche seulement la valeur modifiée, "ASC" et l'"id_genre_update"
            return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=id_genre_update))
        elif request.method == "GET":
            # Opération sur la BD pour récupérer "id_genre" et "intitule_genre" de la "t_genre"
            str_sql_id_genre = "SELECT id_objets, nom_objets, etat_objets FROM t_objets " \
                               "WHERE id_objets = %(value_id_genre)s"
            valeur_select_dictionnaire = {"value_id_genre": id_genre_update}
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_id_genre, valeur_select_dictionnaire)
            # Une seule valeur est suffisante "fetchone()", vu qu'il n'y a qu'un seul champ "nom genre" pour l'UPDATE
            data_nom_genre = mybd_conn.fetchone()
            print("data_nom_genre ", data_nom_genre, " type ", type(data_nom_genre), " genre ",
                  data_nom_genre["nom_objets"])

            # Afficher la valeur sélectionnée dans les champs du formulaire "genre_update_wtf.html"
            form_update.nom_genre_update_wtf.data = data_nom_genre["nom_objets"]
            form_update.date_genre_wtf_essai.data = data_nom_genre["etat_objets"]

    except Exception as Exception_genre_update_wtf:
        raise ExceptionGenreUpdateWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{genre_update_wtf.__name__} ; "
                                      f"{Exception_genre_update_wtf}")

    return render_template("genres/genre_update_wtf.html", form_update=form_update)


"""
    Auteur : OM 2021.04.08
    Définition d'une "route" /genre_delete
    
    Test : ex. cliquer sur le menu "genres" puis cliquer sur le bouton "DELETE" d'un "genre"
    
    Paramètres : sans
    
    But : Effacer(delete) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"
    
    Remarque :  Dans le champ "nom_genre_delete_wtf" du formulaire "genres/genre_delete_wtf.html",
                le contrôle de la saisie est désactivée. On doit simplement cliquer sur "DELETE"
"""


@app.route("/genre_delete", methods=['GET', 'POST'])
def genre_delete_wtf():
    data_films_attribue_genre_delete = None
    btn_submit_del = None
    # L'utilisateur vient de cliquer sur le bouton "DELETE". Récupère la valeur de "id_genre"
    id_genre_delete = request.values['id_genre_btn_delete_html']

    # Objet formulaire pour effacer le genre sélectionné.
    form_delete = FormWTFDeleteGenre()
    try:
        print(" on submit ", form_delete.validate_on_submit())
        if request.method == "POST" and form_delete.validate_on_submit():

            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("genres_afficher", order_by="ASC", id_genre_sel=0))

            if form_delete.submit_btn_conf_del.data:
                # Récupère les données afin d'afficher à nouveau
                # le formulaire "genres/genre_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                data_films_attribue_genre_delete = session['data_films_attribue_genre_delete']
                print("data_films_attribue_genre_delete ", data_films_attribue_genre_delete)

                flash(f"Effacer l'objet de façon définitive de la BD !!!", "danger")
                # L'utilisateur vient de cliquer sur le bouton de confirmation pour effacer...
                # On affiche le bouton "Effacer genre" qui va irrémédiablement EFFACER le genre
                btn_submit_del = True

            if form_delete.submit_btn_del.data:
                valeur_delete_dictionnaire = {"value_id_genre": id_genre_delete}
                print("valeur_delete_dictionnaire ", valeur_delete_dictionnaire)

                str_sql_delete_films_genre = """DELETE FROM t_objets_personne WHERE id_objets = %(value_id_genre)s"""
                str_sql_delete_idgenre = """DELETE FROM t_objets WHERE id_objets = %(value_id_genre)s"""
                # Manière brutale d'effacer d'abord la "fk_genre", même si elle n'existe pas dans la "t_genre_film"
                # Ensuite on peut effacer le genre vu qu'il n'est plus "lié" (INNODB) dans la "t_genre_film"
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(str_sql_delete_films_genre, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_idgenre, valeur_delete_dictionnaire)

                flash(f"Genre définitivement effacé !!", "success")
                print(f"Genre définitivement effacé !!")

                # afficher les données
                return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))

        if request.method == "GET":
            valeur_select_dictionnaire = {"value_id_genre": id_genre_delete}
            print(id_genre_delete, type(id_genre_delete))

            # Requête qui affiche tous les films_genres qui ont le genre que l'utilisateur veut effacer
            str_sql_genres_films_delete = """SELECT top.id_objets_personne, tp.nom, tb.id_objets, tb.nom_objets FROM t_objets_personne top 
                                            INNER JOIN t_personne tp ON top.id_personne = tp.id_personne
                                            INNER JOIN t_objets tb ON top.id_objets = tb.id_objets
                                            WHERE tb.id_objets = %(value_id_genre)s"""

            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_genres_films_delete, valeur_select_dictionnaire)
                data_films_attribue_genre_delete = mydb_conn.fetchall()
                print("data_films_attribue_genre_delete...", data_films_attribue_genre_delete)

                # Nécessaire pour mémoriser les données afin d'afficher à nouveau
                # le formulaire "genres/genre_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                session['data_films_attribue_genre_delete'] = data_films_attribue_genre_delete

                # Opération sur la BD pour récupérer "id_genre" et "intitule_genre" de la "t_genre"
                str_sql_id_genre = "SELECT id_objets, nom_objets FROM t_objets WHERE id_objets = %(value_id_genre)s"

                mydb_conn.execute(str_sql_id_genre, valeur_select_dictionnaire)
                # Une seule valeur est suffisante "fetchone()",
                # vu qu'il n'y a qu'un seul champ "nom genre" pour l'action DELETE
                data_nom_genre = mydb_conn.fetchone()
                print("data_nom_genre ", data_nom_genre, " type ", type(data_nom_genre), " genre ",
                      data_nom_genre["nom_objets"])

            # Afficher la valeur sélectionnée dans le champ du formulaire "genre_delete_wtf.html"
            form_delete.nom_genre_delete_wtf.data = data_nom_genre["nom_objets"]

            # Le bouton pour l'action "DELETE" dans le form. "genre_delete_wtf.html" est caché.
            btn_submit_del = False

    except Exception as Exception_genre_delete_wtf:
        raise ExceptionGenreDeleteWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{genre_delete_wtf.__name__} ; "
                                      f"{Exception_genre_delete_wtf}")

    return render_template("genres/genre_delete_wtf.html",
                           form_delete=form_delete,
                           btn_submit_del=btn_submit_del,
                           data_films_associes=data_films_attribue_genre_delete)



"""page dédié à l'attribution d'un objet à une personne"""

@app.route("/objet_personne", methods=['GET', 'POST'])
def objet_personne_wtf():
    id_genre_update = request.values.get('id_genre_btn_edit_html', None)
    form_assign = FormWTFAttribuerObjet()
    confirm = request.form.get('confirm', None)
    data_films_associes = None

    try:
        if form_assign.submit_btn_annuler.data:
            return redirect(url_for("genres_afficher", order_by="ASC", id_genre_sel=0))

        if request.method == "POST":
            id_personne = form_assign.nom_personne_update_wtf.data

            if not id_personne:
                flash("Veuillez sélectionner une personne pour attribuer l'objet.", "warning")
                return render_template("genres/objet_personne_wtf.html", form_assign=form_assign, confirm=confirm, id_genre_update=id_genre_update, data_films_associes=data_films_associes)

            valeur_update_dictionnaire = {
                "value_id_genre": id_genre_update,
                "value_id_personne": id_personne
            }

            # Vérifiez si l'objet est déjà attribué
            str_sql_check_objets_assigned = """
                SELECT is_assigned FROM t_objets WHERE id_objets = %(value_id_genre)s
            """
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_check_objets_assigned, valeur_update_dictionnaire)
                data_is_assigned = mconn_bd.fetchone()

            if data_is_assigned and data_is_assigned['is_assigned'] == 1:
                if form_assign.submit_btn_del.data:
                    # Mise à jour de l'attribution
                    str_sql_update_objets_personne = """
                        UPDATE t_objets_personne 
                        SET id_personne = %(value_id_personne)s
                        WHERE id_objets = %(value_id_genre)s
                    """
                    with DBconnection() as mconn_bd:
                        mconn_bd.execute(str_sql_update_objets_personne, valeur_update_dictionnaire)

                    flash("Objet réattribué à la nouvelle personne avec succès !!", "success")
                    return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=id_genre_update))
                else:
                    # Affichez un message d'alerte demandant confirmation
                    str_sql_genres_films_delete = """
                        SELECT top.id_objets_personne, tp.nom, tb.id_objets, tb.nom_objets 
                        FROM t_objets_personne top 
                        INNER JOIN t_personne tp ON top.id_personne = tp.id_personne
                        INNER JOIN t_objets tb ON top.id_objets = tb.id_objets
                        WHERE tb.id_objets = %(value_id_genre)s
                    """
                    with DBconnection() as mydb_conn:
                        mydb_conn.execute(str_sql_genres_films_delete, valeur_update_dictionnaire)
                        data_films_associes = mydb_conn.fetchall()

                    flash("Cet objet est déjà attribué à quelqu'un. Voulez-vous réattribuer cet objet à une autre personne ?", "warning")
                    return render_template("genres/objet_personne_wtf.html", form_assign=form_assign, confirm=True, id_genre_update=id_genre_update, id_personne=id_personne, data_films_associes=data_films_associes)

            # Si l'objet n'est pas déjà attribué, procédez à l'attribution
            str_sql_insert_objets_personne = """
                INSERT INTO t_objets_personne (id_objets, id_personne)
                VALUES (%(value_id_genre)s, %(value_id_personne)s)
            """
            str_sql_update_objets = """
                UPDATE t_objets
                SET is_assigned = 1
                WHERE id_objets = %(value_id_genre)s
            """
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_insert_objets_personne, valeur_update_dictionnaire)
                mconn_bd.execute(str_sql_update_objets, valeur_update_dictionnaire)

            flash("Objet attribué à la personne avec succès !!", "success")
            return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=id_genre_update))

        elif request.method == "GET":
            str_sql_id_genre = "SELECT id_objets, nom_objets FROM t_objets WHERE id_objets = %(value_id_genre)s"
            valeur_select_dictionnaire = {"value_id_genre": id_genre_update}
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_id_genre, valeur_select_dictionnaire)
                data_nom_genre = mybd_conn.fetchone()
                form_assign.nom_genre_update_wtf.data = data_nom_genre["nom_objets"]

            str_sql_personnes = "SELECT id_personne, nom FROM t_personne"
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_personnes)
                data_personnes = mybd_conn.fetchall()
                form_assign.nom_personne_update_wtf.choices = [(row['id_personne'], row['nom']) for row in data_personnes]

            str_sql_genres_films_delete = """
                SELECT top.id_objets_personne, tp.nom, tb.id_objets, tb.nom_objets 
                FROM t_objets_personne top 
                INNER JOIN t_personne tp ON top.id_personne = tp.id_personne
                INNER JOIN t_objets tb ON top.id_objets = tb.id_objets
                WHERE tb.id_objets = %(value_id_genre)s
            """
            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_genres_films_delete, valeur_select_dictionnaire)
                data_films_associes = mydb_conn.fetchall()

    except Exception as e:
        raise Exception(f"Erreur lors de la mise à jour : {str(e)}")

    return render_template("genres/objet_personne_wtf.html", form_assign=form_assign, confirm=False, id_genre_update=id_genre_update, id_personne=None, data_films_associes=data_films_associes)