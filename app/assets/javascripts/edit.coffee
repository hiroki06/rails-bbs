onPageLoad ['posts#edit','posts#destroy','posts#update'], ->
    $('input:submit[name="commit"]').on 'click', ->
        $('input:hidden[name="_method"]').val('patch')

    $('input:submit[name="delete"]').on 'click', ->
        $('input:hidden[name="_method"]').val('delete')

