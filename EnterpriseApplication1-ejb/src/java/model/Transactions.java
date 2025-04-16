package model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Transactions implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;

    private String comment;

    private String transStatus;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "salesman_id")
    private Salesman salesman;

    @OneToOne
    @JoinColumn(name = "car_id")
    private Car car;

    @OneToOne
    @JoinColumn(name = "feedback_id")
    private Feedback feedback;

    private String transDate;

    @PrePersist
    public void setDate() {
        Date currentDate = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        String formattedDate = formatter.format(currentDate);
        this.transDate = formattedDate;
    }

}
