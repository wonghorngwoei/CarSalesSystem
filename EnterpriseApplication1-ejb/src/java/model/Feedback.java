package model;

import java.io.Serializable;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;
    private String feedback;
    private String rating;

    @OneToOne(mappedBy = "feedback", cascade = CascadeType.ALL)
    private Transactions transactions;

    @OneToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    private Customer customer;

}
