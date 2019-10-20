module Api
  module V1
    class PostsController < ApplicationController
      bbefore_action ->{
        引数付き実行前メソッド("pan")
      }

      private
      def post_params
        params.require(:post).permit(:users, :title)
      end
    end
  end
end