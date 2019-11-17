module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy, :complete]
      skip_before_action :authenticate_user_from_token!

      def index
        posts = Post.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: post }
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: 'SUCCESS', data: post }
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def complete
        user = User.find(@post.user_id)
        user.point = user.point + @post.point
        if user.save
          @post.destroy
          render json: { status: 'SUCCESS', message: 'TODO達成！', data: @post }
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post.point }
      end

      def update
        if @post.update(post_params)
          render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @post.errors }
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :user_id, :point)
      end
    end
  end
end