package com.example.smartspinapi.repository.impl;

import com.example.smartspinapi.model.dto.multiplayer.MultiplayerQuizSession;
import com.example.smartspinapi.repository.MultiplayerQuizSessionRepository;
import com.google.firebase.database.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@Repository
public class MultiplayerQuizSessionRepositoryImpl implements MultiplayerQuizSessionRepository {

    private final DatabaseReference dbRef;

    @Autowired
    public MultiplayerQuizSessionRepositoryImpl(DatabaseReference firebaseDatabase) {
        this.dbRef = firebaseDatabase.child("multiplayerSessions");
    }

    @Override
    public CompletableFuture<Void> save(String joinCode, MultiplayerQuizSession session) {
        CompletableFuture<Void> future = new CompletableFuture<>();
        dbRef.child(joinCode).setValue(session, (error, ref) -> {
            if (error != null) future.completeExceptionally(error.toException());
            else future.complete(null);
        });
        return future;
    }

    @Override
    public CompletableFuture<MultiplayerQuizSession> findByJoinCode(String joinCode) {
        CompletableFuture<MultiplayerQuizSession> future = new CompletableFuture<>();
        dbRef.child(joinCode).addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                MultiplayerQuizSession session = snapshot.getValue(MultiplayerQuizSession.class);
                future.complete(session);
            }
            @Override
            public void onCancelled(DatabaseError error) {
                future.completeExceptionally(error.toException());
            }
        });
        return future;
    }

    @Override
    public CompletableFuture<List<MultiplayerQuizSession>> findAll() {
        CompletableFuture<List<MultiplayerQuizSession>> future = new CompletableFuture<>();
        dbRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                List<MultiplayerQuizSession> list = new java.util.ArrayList<>();
                for (DataSnapshot child : snapshot.getChildren()) {
                    list.add(child.getValue(MultiplayerQuizSession.class));
                }
                future.complete(list);
            }
            @Override
            public void onCancelled(DatabaseError error) {
                future.completeExceptionally(error.toException());
            }
        });
        return future;
    }

    @Override
    public CompletableFuture<Void> delete(String joinCode) {
        CompletableFuture<Void> future = new CompletableFuture<>();
        dbRef.child(joinCode).removeValue((error, ref) -> {
            if (error != null) future.completeExceptionally(error.toException());
            else future.complete(null);
        });
        return future;
    }
}
