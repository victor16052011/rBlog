class ArticleMailer < ApplicationMailer
	def new_article(article)
		@article = article

		User.all.each do |user|
			mail(to user.email, subject: "Nuevo articulo generado en la UTNG")
		end
	end
end
