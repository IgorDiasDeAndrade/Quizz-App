module SiteHelper

    def msg_questions
        case params[:action]
        when 'index'
            "Latest questions"
        when 'questions'
            "Results for: \"#{params[:term]}\"..."
        when 'subject'
            "Results for subject \"#{params[:subject]}\"..."
        end
    end
end
