require 'open-uri'
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :library]
  before_action :authenticate_user!, except: [:index, :show]
  

  def index
    @books = current_user.books.all
  end

  def show
  end

  def new
    @book = current_user.books.build
  end

  def edit
  end


  def create
    @book = current_user.books.build(book_params)

    if(@book.isbn.blank?)
      booklist = GoogleBooks.search("intitle:#{@book.title}", {:api_key => 'AIzaSyB45FSlnWfaWvjZ_Vq47hB4pmXsNXAMdqI'}, :filter => 'ebooks')
    else
      booklist = GoogleBooks.search("isbn:#{@book.isbn}", {:api_key => 'AIzaSyB45FSlnWfaWvjZ_Vq47hB4pmXsNXAMdqI'}, :filter => 'ebooks')
    end
    firstr = booklist.first
    @book.title = firstr.title
    @book.isbn = firstr.isbn
    @book.author = firstr.authors
    @book.description = firstr.description
    @book.lent = ""
    url = firstr.image_link(:zoom => 3) #Can be 5 to fix issues with missing covers, but poor quality
    if url != nil
      downloaded_image = open(url)
      @book.thumbnail.attach(io: downloaded_image, filename: "cover-#{@book.title}.jpg", content_type: 'image/jpg')
    else
      @book.thumbnail.attach(io: File.open(Rails.root + 'app/assets/images/default.png'), filename: 'cover.jpg', content_type: 'image/jpg')
    end

    respond_to do |format|
      if @book.save
        current_user.library_additions << @book
        format.html { redirect_to root_path, notice: "#{@book.title} was added." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "#{@book.title} was updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "#{@book.title} was removed." }
      format.json { head :no_content }
    end
  end

  # def library
  #   type = params[:type]
    
  #   case type
  #   when "add"
  #     current_user.library_additions << @book
  #     redirect_to root_path, notice: "#{@book.title} was added to your library"
  #   when "remove"
  #     current_user.library_additions.delete(@book)
  #     @book.destroy
  #     redirect_to root_path,notice: "#{@book.title} was removed from your library"
  #   else
  #     redirect_to book_path(@book), notice: "Nothing happened, try again"
  #   end
  # end
  
  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :author, :thumbnail, :isbn, :lent, :user_id)
    end
end
