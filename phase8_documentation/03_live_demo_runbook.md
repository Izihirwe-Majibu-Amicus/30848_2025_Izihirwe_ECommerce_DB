# Live Demo Runbook — Final Presentation

**Goal:** demonstrate the security policy actually blocking and allowing writes, the audit trail proving both outcomes, and the compound trigger firing — in a tight, rehearsed sequence.

---

## Pre-flight checklist

- [ ] Confirm all objects in schema show `STATUS = VALID`.
- [ ] Confirm `AUDIT_LOG` has exactly **one** CHECK constraint on `action_status`.
- [ ] Confirm script `08_add_session_scoped_test_denial.sql` has been executed.
- [ ] Have three SQL*Plus windows connected: `ECOMM_ADMIN`, `mugisha`, and `akarenzi`.

---

## The Demo Sequence (~6–8 minutes)

### 1. Show the policy is configurable, not hardcoded (30 sec)
As `ECOMM_ADMIN`:
```sql
SELECT config_key, config_value FROM system_config;