# Visitez l'URL de test

http://shorter-nans.herokuapp.com/


test user

login : nans.noel@gmail.com

mot de passe : 123456

# GEM utilisé

- devise < Création des Users

- Shortner < Générateur d'URLs minifiés

# Explication

Vous pouvez ajouter un lien sans être connecté :

- Si le lien existe on vous proposera de l'utiliser et on rajoute 3 jours si le lien est expiré

- Si le lien n'existe pas il sera ajouté à la base avec une date d'expiration de 3 jours

Si vous êtes connecté :

- Lorsque vous ajoutez un lien on vérifie que vous ne l'avez pas déjà entré, sinon on l'ajoute même si
un autre utilisateur l'a déjà ajouté.

- Si le lien existe déjà on vous l'affiche et vous devrez vous rendre dans votre interface pour
pouvoir étendre la durée du lien.

# Point à améliorer

- Améliorer les views avec des partials notamment sur les formulaires et les tableaux

- Refactorer le ShortenedUrl dans un service

- Rajouter du jQuery pour recharger les pages instantanéments 
 
# Version

- Rails 5.2.3
- Ruby 2.5.1
- PostgreSQL