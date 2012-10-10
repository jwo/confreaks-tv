jQuery ->
       $('#conferences').dataTable
         sPaginationType: "full_numbers"
         bPaginate: true
         bInfo: true
         iDisplayLength: 25
         aaSorting: [[1,"asc"]]
       