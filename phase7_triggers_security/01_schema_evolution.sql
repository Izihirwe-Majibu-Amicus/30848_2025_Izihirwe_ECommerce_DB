/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 01: Schema Evolution (Audit Log Constraint Update)
  Run as  : ECOMM_ADMIN
==============================================================*/

-- Drop constraint if it exists (using PL/SQL block to handle non-existence gracefully)
begin
   execute immediate 'ALTER TABLE audit_log DROP CONSTRAINT chk_audit_action_status';
exception
   when others then
      null; -- Ignore if constraint does not exist yet
end;
/

-- Add check constraint on ACTION_STATUS
alter table audit_log
   add constraint chk_audit_action_status
      check ( action_status in ( 'ALLOWED',
                                 'DENIED',
                                 'ALERT',
                                 'SUCCESS',
                                 'FAILED' ) );

pro    Schema evolution complete: AUDIT_LOG constraints updated successfully.