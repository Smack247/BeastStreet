class PostsController < ApplicationController
before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote] #Cool this method inside of find_post will get the post by its parameters and only display for edit, destroy,
before_action :authenticate_user!, except: [:index, :show] #You need to sign up thank to devise
def index # def index make template
@posts = Post.all.order("created_at DESC")
end

def show
	@comments = Comment.where(post_id: @post)
	@random_post = Post.where.not(id: @post).order("RANDOM()").first
end

def new 
@post = current_user.posts.build #redefining a post. We are saying that a post is created by a user
end

def create
@post = current_user.posts.build(post_params) #Makes sure the user id column in the posts table is filled in when we create a post 

if @post.save
	redirect_to @post #if it successfully saves redirect to post
else
	render 'new' #if it doesn't keep showing them the new form
	end
end 

def edit
end

def update
	if @post.update(post_params)
		redirect_to @post
	else
	 render 'edit'
	end
end

def destroy
@post.destroy
redirect_to root_path
end

def upvote
	@post.upvote_by current_user
	redirect_to :back
end

def downvote
	@post.downvote_by current_user
	redirect_to :back
end


private

def find_post
@post = Post.find(params[:id]) #we want this for the edit destory and update action
end

def post_params
		params.require(:post).permit(:title, :link, :description, :image)
	end

end
