jQuery ->
       $('#videos').dataTable
         sPaginationType: "full_numbers"
         bPaginate: true
         bInfo: true
         iDisplayLength: 100
         aaSorting: [[2,"desc"]]