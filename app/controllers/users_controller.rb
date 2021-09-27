class UsersController < ApplicationController
 before_action :correct_user, only: [:edit, :update]
def index
  @book = Book.new
  @users =User.all
  @user =current_user
end

def show
  @user =User.find(params[:id])
  @booknew =Book.new
  @books =@user.books
end

def edit
#   if params[:id] == current_user.id
  @user = User.find(params[:id])
#     render :edit
#   else
#     @user = current_user
#     redirect_to user_path(@user.id)
#   end
end

def create
  @book =Book.new(book_params)
  @book.user_id = current_user.id
  @book.save
  redirect_to book_path(@book.id)
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user.id),notice:"You have update user successfully."
  else
    render:edit
  end
end


private
def user_params
  params.require(:user).permit(:name, :introduction,:profile_image)
end
def book_params
  params.require(:book).permit(:title, :body)
end

def correct_user
  @user =User.find(params[:id])
  unless @user == current_user
    redirect_to user_path(current_user)
  end
end

end
