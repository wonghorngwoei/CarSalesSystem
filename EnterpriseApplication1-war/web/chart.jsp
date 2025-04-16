<script>
    // Payment Chart
    var ctx = document.getElementById('transactionChart');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Pending', 'Completed', 'Cancelled'],
            datasets: [{
                    label: 'Transaction Count',
                    data: [<%= request.getAttribute("pendingTransCount")%>, <%= request.getAttribute("completedTransCount")%>, <%= request.getAttribute("cancelledTransCount")%>],
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
                }]
        },
        options: {
            scales: {
                yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
            }
        }
    });

// Feedback Chart
    var ctx = document.getElementById('feedbackChart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Poor', 'Neutral', 'Good'],
            datasets: [{
                    label: 'Feedback Count',
                    data: [<%= request.getAttribute("poorCount")%>, <%= request.getAttribute("neutralCount")%>, <%= request.getAttribute("goodCount")%>],
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
                }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            aspectRatio: 0.8
        }
    });



    //Salesman & Customer Report
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Customers', 'Salespersons'],
            datasets: [{
                    label: 'Total Records',
                    data: [<%= request.getAttribute("customerCount")%>, <%= request.getAttribute("salespersonCount")%>],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)'
                    ],
                    borderWidth: 1
                }]
        },
        options: {
            scales: {
                yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
            }
        }
    });

    // Inventory Report
    var inventoryData = {
        labels: ['Available', 'Booked', 'Paid', 'Cancelled'],
        datasets: [{
                data: [<%= request.getAttribute("availableCount")%>, <%= request.getAttribute("bookedCount")%>, <%= request.getAttribute("paidCount")%>, <%= request.getAttribute("cancelledCount")%>],
                backgroundColor: [
                    '#2ecc71',
                    '#3498db',
                    '#f1c40f',
                    '#e74c3c'
                ]
            }]
    };

    var inventoryChart = new Chart(document.getElementById('inventoryChart'), {
        type: 'pie',
        data: inventoryData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            legend: {
                display: true,
                position: 'right',
                labels: {
                    fontColor: '#333',
                    fontSize: 12
                }
            },
            title: {
                display: true,
                text: 'Inventory Report',
                fontSize: 16,
                fontColor: '#333',
                fontStyle: 'bold',
                padding: 10
            }
        }
    });

    //Gender Report
    // Get gender count data from the request attribute
    var genderCounts = ${genderCounts};

    // Extract male and female counts from the genderCounts list
    var maleCount = genderCounts[0];
    var femaleCount = genderCounts[1];

    // Create a bar chart using Chart.js
    var genderData = {
        labels: ['Male', 'Female'],
        datasets: [{
                label: 'Gender Count',
                data: [maleCount, femaleCount],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }]
    };

    var ctx = document.getElementById('genderChart').getContext('2d');
    var genderChart = new Chart(ctx, {
        type: 'bar',
        data: genderData,
        options: {
            scales: {
                xAxes: [{
                        gridLines: {
                            display: false
                        },
                        ticks: {
                            beginAtZero: true,
                            fontColor: "#000"
                        }
                    }],
                yAxes: [{
                        gridLines: {
                            display: false
                        },
                        ticks: {
                            beginAtZero: true,
                            fontColor: "#000"
                        }
                    }]
            },
            legend: {
                display: true,
                position: 'top',
                labels: {
                    fontColor: '#000'
                }
            },
            responsive: true,
            maintainAspectRatio: false
        }
    });

</script>
