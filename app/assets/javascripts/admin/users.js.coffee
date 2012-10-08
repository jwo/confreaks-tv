jQuery ->
       $('#users').dataTable
         sPaginationType: "full_numbers"
         bPaginate: true
         bInfo: true
         iDisplayLength: 25
         aaSorting: [[2,"asc"],[1,"asc"]]