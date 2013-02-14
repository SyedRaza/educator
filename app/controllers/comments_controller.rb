class CommentsController < ApplicationController

  def index
    #    @comments = Comments.all
          @comments = [
      {
        :image =>'user4.jpg',
        :user_id =>1,
        :user_name =>'Tariq',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      },
      {
        :image =>'user3.jpg',
        :user_id =>2,
        :user_name =>'Kamaal',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      },
      {
        :image =>'user2.jpg',
        :user_id =>3,
        :user_name =>'Raza',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      },
      {
        :image =>'user.jpg',
        :user_id =>4,
        :user_name =>'Ayaz',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      },
      {
        :image =>'user3.jpg',
        :user_id =>5,
        :user_name =>'Abdul',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      },
      {
        :image =>'user4.jpg',
        :user_id =>6,
        :user_name =>'Nazar',
        :mainbody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dignissim semper mauris, id congue risus fringilla sit amet. Nunc nec quam erat, sollicitudin sodales risus. Aenean leo nisl, fermentum a malesuada sit amet, scelerisque quis libero. Cras in leo erat, in facilisis purus.'
      }
    ]
     unless params[:value].nil?
       @comments = @comments[0...2]
     end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @comments }
    end
  end

end
