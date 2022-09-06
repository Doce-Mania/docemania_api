json.(user, :id, :email, :name, :phone, :cpf)
json.token user.generate_jwt