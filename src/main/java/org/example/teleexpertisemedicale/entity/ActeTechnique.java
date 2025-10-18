package org.example.teleexpertisemedicale.entity;

import jakarta.persistence.*;
import org.example.teleexpertisemedicale.enums.TypeActe;
import java.util.UUID;

@Entity
public class ActeTechnique {

    @Id
    @GeneratedValue
    private UUID id;

    @Enumerated(EnumType.STRING)
    private TypeActe type;

    // Getters & Setters

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public TypeActe getType() {
        return type;
    }

    public void setType(TypeActe type) {
        this.type = type;
    }
}