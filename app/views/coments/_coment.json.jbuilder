json.extract! coment, :id, :user_id, :article_id, :body, :created_at, :updated_at
json.user do 
	json.email @coment.user.email
end
#json.url coment_url(coment, format: :json)
json.url article_url(coment, format: :json)