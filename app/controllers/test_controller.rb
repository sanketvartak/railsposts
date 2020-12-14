class TestController < ApplicationController
    def index
    end
    def new
    end
    def show
      @test_index = test.find(params[:id])
    end
    def create
        @test_index =test_path.new(params[:test_params],0)
        @test_index.save
        redirect_to @test_index
    end
    private def test_params
      params.require(:test_index).permit(:title, :body)
    end 
end
