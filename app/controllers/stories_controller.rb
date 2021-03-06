class StoriesController < ApplicationController

    def index
        Story.all.each do |story|
            if story.sentences.length < 7
                story.delete
            end
        end
        @stories = Story.all
        id_of_3_stories = @stories.map{|story| story.id}.sample(3).shuffle #[4,2,6]
        @id_1 = id_of_3_stories[0]
        @id_2 = id_of_3_stories[1]
        @id_3 = id_of_3_stories[2]
        @array_of_3_stories = []
        id_of_3_stories.each do |id|
            # @array_of_3_stories << sentences_array(id)
            all_s = Sentence.all.select {|sentence| sentence.story_id == id}
            puts all_s
            s1_obj = all_s.find { |s| s.sentence_start == "Once upon a time, "}
            s1 = s1_obj.sentence_start + s1_obj.sentence_text
            s2_obj = all_s.find { |s| s.sentence_start == "Every day, "}
            s2 = s2_obj.sentence_start + s2_obj.sentence_text
            s3_obj = all_s.find { |s| s.sentence_start == "One day, "}
            s3 = s3_obj.sentence_start + s3_obj.sentence_text
            s4_obj = all_s.find { |s| s.sentence_start == "Because of that, "}
            s4 = s4_obj.sentence_start + s4_obj.sentence_text
            s5_obj = all_s.find { |s| s.sentence_start == "And because of that, "}
            s5 = s5_obj.sentence_start + s5_obj.sentence_text
            s6_obj = all_s.find { |s| s.sentence_start == "Until finally, "}
            s6 = s6_obj.sentence_start + s6_obj.sentence_text
            s7_obj = all_s.find { |s| s.sentence_start == "In conclusion, "}
            s7 = s7_obj.sentence_start + s7_obj.sentence_text
            story = [s1,s2,s3,s4,s5,s6,s7]
            @array_of_3_stories << story
        end
    end

    def new
        story_id = params[:story_id]
            @team_id = params[:team_id]
            @team = Team.find(params[:team_id])
            teller_id_list = @team.id_list.split(",").map { |s| s.to_i }
            random_ids = teller_id_list.shuffle
            @teller = []
            random_ids.each do |id|
                @teller << Teller.find_by_id(id)
            end
        #this is for determining teller's turns.
            if @teller.length == 1
                6.times do |t|
                @teller << @teller[0]
                end
            elsif @teller.length == 2
                @teller << @teller[0]
                @teller << @teller[1]
                @teller << @teller[0]
                @teller << @teller[1]
                @teller << @teller[0]
            elsif @teller.length == 3
                @teller << @teller[0]
                @teller << @teller[1]
                @teller << @teller[2]
                @teller << @teller[0]
            elsif @teller.length == 4
                @teller << @teller[0]
                @teller << @teller[1]
                @teller << @teller[2]
            elsif @teller.length == 5
                @teller << @teller[0]
                @teller << @teller[1]
            elsif @teller.length == 6
                @teller << @teller[0]
            end
        @story = Story.create
        @s1 = Sentence.new(sentence_start:"Once upon a time, ", sentence_text: "", story_id: @story.id, teller_id: @teller[0].id)
        @s2 = Sentence.new(sentence_start:"Every day, ", sentence_text: "", story_id: @story.id, teller_id: @teller[1].id)
        @s3 = Sentence.new(sentence_start:"One day, ", sentence_text: "", story_id: @story.id, teller_id: @teller[2].id)
        @s4 = Sentence.new(sentence_start:"Because of that, ", sentence_text: "", story_id: @story.id, teller_id: @teller[3].id)
        @s5 = Sentence.new(sentence_start:"And because of that, ", sentence_text: "", story_id: @story.id, teller_id: @teller[4].id)
        @s6 = Sentence.new(sentence_start:"Until finally, ", sentence_text: "", story_id: @story.id, teller_id: @teller[5].id)
        @s7 = Sentence.new(sentence_start:"In conclusion, ", sentence_text: "", story_id: @story.id, teller_id: @teller[6].id)

        if @s1.sentence_start && @s1.sentence_text && @s2.sentence_start && @s2.sentence_text && @s3.sentence_start && @s3.sentence_text && @s4.sentence_start && @s4.sentence_text && @s5.sentence_start && @s5.sentence_text && @s6.sentence_start && @s6.sentence_text && @s7.sentence_start && @s7.sentence_text
            puts "New story is created."
        elsif @story.sentences.length < 7
            @story.delete
            redirect_to stories_path
        else
            @story.delete
            redirect_to stories_path
        end
    end

    def show
        @story = Story.find(params[:id])
        if @story.sentences.length == 7
            all_s = Sentence.all.select {|sentence| sentence.story_id == @story.id}
            #return all sentences of the story
            s1_obj = all_s.find { |s| s.sentence_start == "Once upon a time, "}
            @s1 = s1_obj.sentence_start + s1_obj.sentence_text
            s2_obj = all_s.find { |s| s.sentence_start == "Every day, "}
            @s2 = s2_obj.sentence_start + s2_obj.sentence_text
            s3_obj = all_s.find { |s| s.sentence_start == "One day, "}
            @s3 = s3_obj.sentence_start + s3_obj.sentence_text
            s4_obj = all_s.find { |s| s.sentence_start == "Because of that, "}
            @s4 = s4_obj.sentence_start + s4_obj.sentence_text
            s5_obj = all_s.find { |s| s.sentence_start == "And because of that, "}
            @s5 = s5_obj.sentence_start + s5_obj.sentence_text
            s6_obj = all_s.find { |s| s.sentence_start == "Until finally, "}
            @s6 = s6_obj.sentence_start + s6_obj.sentence_text
            s7_obj = all_s.find { |s| s.sentence_start == "In conclusion, "}
            @s7 = s7_obj.sentence_start + s7_obj.sentence_text
        else
            @story.delete

        end
    end

    def edit
        @story = Story.find(params[:id])
        # TODO: continue writing the logic for the route
    end

    def create
        @story = Story.create(story_params)
        if @story.valid?
            redirect_to @story
        else
            flash[:message] = @story.errors.full_messages
            render :new
        end
    end

    private

    def story_params
        params.require(:story).permit(list_of_player)
    end

end
