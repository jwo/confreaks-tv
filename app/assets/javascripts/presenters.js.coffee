jQuery ->
       $('#presenters').dataTable
         sPaginationType: "full_numbers"
         bPaginate: true
         bInfo: true
         aaSorting: [[2, "asc"],[3,"asc"]]
         iDisplayLength: 25