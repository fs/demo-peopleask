var js = {
    question: {
        loading: function() {
            Element.hide('suggest');
            Element.show('question_spinner');
        },
        complete: function() {
            Element.hide('question_spinner');
            Element.show('suggest');
        }
    }
}
    